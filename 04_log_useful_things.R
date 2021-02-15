### These comments are not necessary, but may help you as a new programmer
library(DBI)
library(logger) # talk to your IT/ support for other options.
log_threshold(INFO) #This log level determines what gets written to the log
# logs in the IT world are from finegrained to global: (see ?log_levels)
# 
# FATAL severe error that will prevent the application from continuing
# ERROR An error in the application, possibly recoverable
# WARN An event that might possible lead to an error
# SUCCESS An explicit success event above the INFO level that you want to log
# INFO An event for informational purposes
# DEBUG A general debugging event
# TRACE A fine-grained debug message, typically capturing the flow through the application.
# 
# Writes to console by default, but can also log to a file, 
# or you can even write to slack/ pushbullet,  etc see ?appender_file for info
log_appender(appender_file('04_log.txt'))
### Search for env vars, if not found set to NA
uid <- Sys.getenv("SQLSERVER_UID",unset = NA)
pwd <- Sys.getenv("SQLSERVER_PWD",unset = NA)
## if any is not found, the process cannot work. So use stop to terminate the 
## process. 
## Log on level error (or fatal) 
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
### get last 7 days of sales
query <- paste0(
    "SELECT ", 
    "AVG(sales) AS sales_forecast,",
    "STDEV(sales) as sales_std ",
    "FROM sales_table ",
    "WHERE sales_date > ", as.character(today-7),
    " AND sales_date < ",as.character(today),
    " AND sales >0 ",
    "GROUP BY sales_date"
)
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
    description = "7 day rolling average, bound by zero"
)
DBI::dbAppendTable(database_connection, 'sales_forecast', 
                   # Append one row to table 
                   forecast
)
DBI::dbDisconnect(database_connection)
