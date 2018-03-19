# Ruby-Selenium Docker Image

## Getting Started: 

Clone this Repo  
`git clone git@github.com:HarshwardhanSingh/learn-docker.git`  

CD into the project  
`cd learn-docker`  

Build docker image  
`docker build -t ruby-selenium .`  

Start the container  
`docker run -p 80:80 -v /path/to/main.rb/file/on/host:/usr/src/app/ ruby-selenium`  

## Usage:

Visit `http://localhost/` and supply the url of which you want to capture the screenshot like  

`http://localhost?url=http://google.com`