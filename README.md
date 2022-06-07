# HCL_devsecops

## training plan 

<img src="plan.png">

## DOcker more details 

### lets check connection from docker client to docker host 

```
 docker  context  ls
NAME              DESCRIPTION                               DOCKER ENDPOINT               KUBERNETES ENDPOINT   ORCHESTRATOR
default           Current DOCKER_HOST based configuration   unix:///var/run/docker.sock                         swarm
remote-docker *                                             tcp://172.31.19.171:2375                            
[ashu@ip-172-31-46-30 automation]$ 


```
###

```
 docker images
REPOSITORY   TAG       IMAGE ID       CREATED      SIZE
httpd        latest    98f93cd0ec3b   9 days ago   144MB
[ashu@ip-172-31-46-30 automation]$ 

```

### docker registry is a place where all images are present 

<img src="reg.png">

### pulling image from docker hub 

```
[ashu@ip-172-31-46-30 automation]$ docker  pull  alpine 
Using default tag: latest
latest: Pulling from library/alpine
2408cc74d12b: Pull complete 
Digest: sha256:686d8c9dfa6f3ccfc8230bc3178d23f84eeaf7e457f36f271ab1acc53015037c
Status: Downloaded newer image for alpine:latest
docker.io/library/alpine:latest
[ashu@ip-172-31-46-30 automation]$ docker  images
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
python       latest    e4ccc57bca82   4 days ago    920MB
httpd        latest    98f93cd0ec3b   9 days ago    144MB
alpine       latest    e66264b98777   2 weeks ago   5.53MB
[ashu@ip-172-31-46-30 automation]$ 


```

### pulling image from quay registry 

```
docker pull quay.io/centos7/httpd-24-centos7 
Using default tag: latest
latest: Pulling from centos7/httpd-24-centos7
c61d16cfe03e: Pull complete 
53fe1d286177: Pull complete 
d127ac58990a: Pull complete 
Digest: sha256:387987889f8851668a5d7fc409d96d7723459b723d7634b2a60c9bdc1122dc96
Status: Downloaded newer image for quay.io/centos7/httpd-24-centos7:latest
quay.io/centos7/httpd-24-centos7:latest
[ashu@ip-172-31-46-30 automation]$ docker  imaegs
docker: 'imaegs' is not a docker command.
See 'docker --help'
[ashu@ip-172-31-46-30 automation]$ docker  images
REPOSITORY                         TAG       IMAGE ID       CREATED       SIZE
python                             latest    e4ccc57bca82   4 days ago    920MB
quay.io/centos7/httpd-24-centos7   latest    6a19179a7911   6 days ago    344MB
httpd                              latest    98f93cd0ec3b   9 days ago    144MB
alpine                             latest    e66264b98777 
```

### life cycle of a container 

<img src="lifec.png">

### check more docker understanding commands 

```
183  docker  ps
  184  docker  logs  ashuc1 

```

###  access container shell

```
 docker  exec -it  ashuc1  sh 
/ # 
/ # 
/ # cat  /etc/os-release 
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.16.0
PRETTY_NAME="Alpine Linux v3.16"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
/ # 
/ # exit

```

### to kill contaienr forcefully --

```
docker  kill ashuc1
```
### now if you want to remove container forever 

```
docker  rm  ashuc1
```


