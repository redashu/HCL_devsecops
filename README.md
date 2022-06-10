# HCL_devsecops

## training plan 

<img src="plan.png">

### Docker compose and github concept 

<img src="composegit.png">

### some compose examples 

### example 1 

```
version: '3.8'
services:
  ashuapp1: # name of app for compose 
    image: alpine
    container_name: ashuc001 
    command: ping fb.com 

# docker run --name ashu001 alpine ping fb.com  
  

```

### running it 

```
[ashu@ip-172-31-46-30 automation]$ cd  ashu-compose-test/
[ashu@ip-172-31-46-30 ashu-compose-test]$ ls
docker-compose.yaml
[ashu@ip-172-31-46-30 ashu-compose-test]$ docker-compose up -d 
[+] Running 2/2
 ⠿ Network ashu-compose-test_default  Created                                            0.1s
 ⠿ Container ashuc001                 Started                                            1.0s
[ashu@ip-172-31-46-30 ashu-compose-test]$ 
```

### few more commands 

```
docker-compose ps
NAME                COMMAND             SERVICE             STATUS              PORTS
ashuc001            "ping fb.com"       ashuapp1            running             
[ashu@ip-172-31-46-30 ashu-compose-test]$ docker-compose kill
[+] Running 1/1
 ⠿ Container ashuc001  Killed                                                            0.2s
[ashu@ip-172-31-46-30 ashu-compose-test]$ docker-compose ps
NAME                COMMAND             SERVICE             STATUS              PORTS
ashuc001            "ping fb.com"       ashuapp1            exited (137)        
[ashu@ip-172-31-46-30 ashu-compose-test]$ docker-compose start
[+] Running 1/1
 ⠿ Container ashuc001  Started                               

```

### clean up 

```
[ashu@ip-172-31-46-30 ashu-compose-test]$ docker-compose  down 
[+] Running 2/2
 ⠿ Container ashuc001                 Removed                                           10.2s
 ⠿ Network ashu-compose-test_default  Removed                                            0.1s
[ashu@ip-172-31-46-30 ashu-compose-test]$ 
```

### example 2 

```
version: '3.8'
services:
  ashuapp2: 
    image: ashuhcl:appv2 # name of image want to build
    build: . # location of dockerfile
    container_name: ashuc002
    ports:
    - 1234:80 
  ashuapp1: # name of app for compose 
    image: alpine
    container_name: ashuc001 
    command: ping fb.com 

# docker run --name ashu001 alpine ping fb.com  
  

```

### running it 

```
 docker-compose  up -d --build 
[+] Building 0.4s (7/7) FINISHED                                                              
 => [internal] load build definition from Dockerfile                                     0.0s
 => => transferring dockerfile: 272B                                                     0.0s
 => [internal] load .dockerignore                                                        0.0s
 => => transferring context: 2B                                                          0.0s
 => [internal] load metadata for docker.io/library/nginx:latest                          0.0s
 => [internal] load build context                                                        0.1s
 => => transferring context: 1.33MB                                                      0.0s
 => CACHED [1/2] FROM docker.io/library/nginx                                            0.0s
 => [2/2] ADD project-html-website /usr/share/nginx/html/                                0.1s
 => exporting to image                                                                   0.0s
 => => exporting layers                                                                  0.0s
 => => writing image sha256:d980f79380b6c5fd503128c6be6fd58cf04182a8e38ecc5cbc0d475cbe7  0.0s
 => => naming to docker.io/library/ashuhcl:appv2                                         0.0s
[+] Running 3/3
 ⠿ Network ashu-compose-test_default  Created                                            0.1s
 ⠿ Container ashuc001                 Started                                            1.1s
 ⠿ Container ashuc002                 Started        

```

### container are good and also light weight fast , easy to build 

### we have a new problem 

<img src="prob1.png">

### introduction to container orchestration engine 

<img src="carch.png">

### k8s use case with netflix 

<img src="netflix.png">


