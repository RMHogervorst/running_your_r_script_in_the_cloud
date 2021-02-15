library(DBI)

# finding environmental variables allows you to not hardcode secrets in the
# script. Alternatively you could supply them as arguments to Rscript but that
# kind of defeats the purpose. Finding environmental variables also allows you
# to have different credentials in testing and production, without changing the
# script! 
database_connection <- dbConnect(
    odbc::odbc(), 
    dsn = "MicrosoftSQLServer", 
    UID = Sys.getenv("SQLSERVER_UID"), 
    PWD = Sys.getenv("SQLSERVER_PWD"),
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
