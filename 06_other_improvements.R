### other improvements:
### * make nr of days looking back variable
### * guard against negative or 0 days looking back
### * optionally replace handwritten query with dplyr syntax

library(DBI)
library(logger) 
log_threshold(INFO)

log_appender(appender_file('04_log.txt'))
uid <- Sys.getenv("SQLSERVER_UID",unset = NA)
pwd <- Sys.getenv("SQLSERVER_PWD",unset = NA)
days_back <- Sys.getenv('DAYS_BACK',unset=7)
if(as.numeric(days_back)< 1)stop("Need to set a positive DAYS_BACK value")
if(any(is.na(uid), is.na(pwd))){
    log_error("UID or PASSWORD env vars not found")
    stop("uid or password not found",call. = FALSE)
}

database_connection <- dbConnect(
    odbc::odbc(), 
    dsn = "MicrosoftSQLServer", 
    UID = uid, 
    PWD = pwd,    
    host = "12.323.455.45", # somewhere on the internet
    port = 5432)

today <- Sys.Date()
query <- paste0(
    "SELECT ", 
    "AVG(sales) AS sales_forecast,",
    "STDEV(sales) as sales_std ",
    "FROM sales_table ",
    "WHERE sales_date > ", as.character(today-as.integer(days_back)),
    " AND sales_date < ",as.character(today),
    " AND sales >0 ",
    "GROUP BY sales_date"
)
### alternative that works on every database:
### library(dplyr)
### library(dbplyr)
### sales_forecast <- tbl(database_connection, "sales_forecast")
### sales_forecast %>% 
###     filter(sales_date > as.character(today-as.integer(days_back))) %>% 
###     filter(sales_date < as.character(today)) %>% 
###     filter(sales > 0) %>% 
###     group_by(sales_date) %>% 
###     summarize(
###         sales_forecast = mean(sales, na.rm=TRUE), 
###         sales_std = sd(sales, na.rm=TRUE)
###     ) 
###     

result <- DBI::dbGetQuery(database_connection, query)
if(nrow(result)==0){
    log_error("No results from sales_table")
    stop("No results returned from database")
}
log_info("Retrieved {nrow(result)} rows from sales_table")

forecast <- data.frame(
    date = as.character(today),
    sales_forecast = result$sales_forecast, 
    upperbound = result$sales_forecast + result$sales_std,
    lowerbound = max(0, result$sales_forecast - result$sales_std),
    description = paste0(days_back," day rolling average, bound by zero")
)
DBI::dbAppendTable(database_connection, 'sales_forecast', 
                   # Append one row to table 
                   forecast
)
DBI::dbDisconnect(database_connection)
