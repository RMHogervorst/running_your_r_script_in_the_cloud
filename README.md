This is the repo associated with my talk for why-R on 2020-02-18
`Why R? Webinar 034 - Roel Hogervorst - Running your Rscript in the cloud`

The video will stream live on [youtube here](https://youtu.be/1t47U_nBXdE)
and can also be found there afterwards.


The presentation is [here in google slides](https://docs.google.com/presentation/d/19puC6i6Q7iZuIZJ6ErvtenPJhial976TsI769qFa0Wc/edit?usp=sharing)

# Description of talk
Life as member of a data team is awesome but as a lone data scientist in a small company you have to be data engineer, IT consultant and data scientist all in one. So how do you get your R scripts to run? In this talk I hope to inspire lone data scientists on all the ways you can run your Rscript in the cloud. I cover some simple and more advanced use cases for running R in the cloud. I also talk about cooperating with IT for maximum results.


### Script progression of exploratory to production ready
In the talk I explain about how you get your exploratory script to a more production
ready script. 
In [from exploration to script (another markdown document in this repo)](from_exploration_to_script.md) you can see a progression where I add logging, informative logging and error quickly. 



### Links in the presentation
- [Ordina](https://www.ordina.nl/en/business-propositions/intelligent-data-driven-organisations/)
- Contact me, or go to [this page for vacancies at Ordina](https://www.ordina.nl/werkenbij/)
- https://en.wikipedia.org/wiki/Shadow_IT
- [Why-R 005: Development pipeline for R in production - Lorenzo Braschi](https://www.youtube.com/watch?v=YyG8E1DdhX0)
- [this page (you are reading right now) on github](github.com/RMHogervorst/running_your_r_script_in_the_cloud)

**Virtual machines**

- [My personal pros and cons of running locally on a VM or using one of the other services ](https://github.com/RMHogervorst/scheduling_r_scripts)
- [Azure (microsoft cloud) virtual machine, this one has several tools already installed](https://azure.microsoft.com/en-us/services/virtual-machines/data-science-virtual-machines/)
- [AWS (amazon cloud) virtual machines (elastic compute; ec2)](https://aws.amazon.com/ec2/)
- [GCP (google cloud) virtual machines (Compute engine; CE)](https://cloud.google.com/compute/)


**running scripts from version control**

- [collection of R specific github-actions](https://github.com/r-lib/actions)
- [online book of R specific github actions](https://ropenscilabs.github.io/actions_sandbox/)
- [My post about gitlab CI to run once a day](https://blog.rmhogervorst.nl/blog/2020/09/24/running-an-r-script-on-a-schedule-gitlab/)
- [building an R package with gitlab](https://persado.github.io/2019/10/23/R-gitlab-pipelines.html)

- [overview page of all the ways you can schedule your scripts](https://blog.rmhogervorst.nl/blog/2020/09/26/running-an-r-script-on-a-schedule-overview/)


**docker resources**

- [docker tutorial by ropensci](https://ropenscilabs.github.io/r-docker-tutorial/)
- [thinkR how to develop inside a docker container for easy collaboration](https://rtask.thinkr.fr/how-to-develop-inside-a-docker-container-to-ease-collaboration/)
- [Docker for the useR - talk by Noam Ross 2018](https://github.com/noamross/nyhackr-docker-talk)
- [{containerit} package (not on CRAN)](http://o2r.info/containerit/) for automatically creating a dockercontainer
- [an example of dockerizing a script by me](https://github.com/RMHogervorst/dockerize_script)
- [{liftr}](https://liftr.me/) for rmarkdown docker containers
- [youtube video about containers (Scott Hanselman)](https://youtu.be/0oEsMwSxBsk)
- [Colin Fay's docker r reproduciblity post (Januari 2019)](https://colinfay.me/docker-r-reproducibility/)

**Using gitlab and github**
- [this repo has a gitlab script, heroku examle and github example to schedule a script](https://github.com/RMHogervorst/invertedushape)
- [this repo makes use of a docker registry, first building one and later retrieving one](https://github.com/RMHogervorst/dockerize_script)

- https://github.com/RMHogervorst/scheduling_r_scripts
- https://github.com/RMHogervorst/rscript_serverless

### Mentioned packages
- [{renv}](https://CRAN.R-project.org/package=renv)
- [{logger}](https://CRAN.R-project.org/package=logger)
- [{taskscheduleR}](https://cran.r-project.org/package=taskscheduleR)
- [{cronR}](https://cran.r-project.org/package=cronR)
- [{dockerit}](http://o2r.info/containerit/)
- [{liftr}](https://liftr.me/) 



### Contacting me
- [@RoelMHogervorst](https://twitter.com/RoelMHogervorst)
- [mastodon.technology/@rmhogervorst](https://mastodon.technology/@rmhogervorst)
- [github RMHogervorst](https://github.com/RMHogervorst)
- [gitlab RMHogervorst](https://gitlab.com/RMHogervorst)
- [blog rmhogervorst.nl](https://blog.rmhogervorst.nl/) (also syndicated on r-bloggers)
