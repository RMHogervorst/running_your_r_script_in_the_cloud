# From explorative R script to a runnable script


* [01_start_script.R](01_start_script.R) is the result of your exploration
* 00 run the script with `Rscript name_of_script.R` to see if the script actually works.
* [02_dealing_with_secrets.R](02_dealing_with_secrets.R) move the hardcoded secrets to an `.Renviron` file. these text files are read by the R script locally. Using `Sys.getenv()` reads in any of the env variables, env vars are used in all programming languages. So if you make sure those secrets are supplied by operations / startup of the machine or whatever process you make sure these secrets stay secret and never end up in scripts and logs.
* [03_error_quickly.R](03_error_quickly.R) Fail when the program cannot work, fail clearly
* [04_log_useful_things.R](04_log_useful_things.R) don't log everything, log pieces that can change and that would help you debug (on level DEBUG). 
* 05 use renv to lock down R packages. simply run `renv::snapshot()` to write a logfile.
* [06_other_improvements](06_other_improvements.R) making more things configurable such as days we look back, writing dplyr in stead of SQL. 
* Other options are: turning loose parts into functions, save the functions in another file and make this script only the high level functions - connect, - retrieve, - forecast, - write back to database.




# read more
* [What they forgat to teach you about R, R startup](https://rstats.wtf/r-startup.html) talks about how R reads environmental variables 
* [Rstudio support page that talks about .Renviron and secrets](https://support.rstudio.com/hc/en-us/articles/360047157094-Managing-R-with-Rprofile-Renviron-Rprofile-site-Renviron-site-rsession-conf-and-repos-conf)
