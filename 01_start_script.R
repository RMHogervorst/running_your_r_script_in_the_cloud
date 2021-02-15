### This script is full of bad practices, please don't copy this!
### It has hardcoded passwords and usernames
### it creates a custom sql query that can be easily abused
### If you want to copy an example script, use one of the later ones.


### this is a script that will improve sales forecasting
### Current state of the art is using the sales of yesterday

# 2020-01-05
### packages
library(DBI)
#library(dplyr)

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
# contains sales_forecast, sales_std

## connect to the db
database_connection <- dbConnect(
    odbc::odbc(), 
    dsn = "MicrosoftSQLServer", 
    UID = "roelmhogervorst", 
    PWD = "Hackerman1",
    host = "12.323.455.45", # somewhere on the internet
    port = 5432
)

## queries for exploration
# 
# plot creation
# other packages.
# library(ggplot2)
# result %>% 
#     ggplot(aes(sales, sales_date))+
#     geom_point()+
#     geom_line()
forecast <- data.frame(
    date = as.character(today),
    sales_forecast = result$sales_forecast, 
    upperbound = result$sales_forecast + result$sales_std,
    lowerbound = max(0, esult$sales_forecast - result$sales_std),
    description = "7 day rolling average, bound by zero"
    )

DBI::dbAppendTable(database_connection, 'sales_forecast', 
                   # Append one row to table 
                   forecast
                   )

## other stuff
DBI::dbDisconnect(database_connection)
