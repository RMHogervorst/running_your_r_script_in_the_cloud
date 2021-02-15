library(DBI)
### Search for env vars, if not found set to NA
uid <- Sys.getenv("SQLSERVER_UID",unset = NA)
pwd <- Sys.getenv("SQLSERVER_PWD",unset = NA)
## if any is not found, the process cannot work. So use stop to terminate the 
## process. 
if(any(is.na(uid), is.na(pwd))){stop("uid or password not found",call. = FALSE)}

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
if(nrow(result)==0){stop("No results returned from database")}

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
