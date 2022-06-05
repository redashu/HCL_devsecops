# HCL_devsecops

## training plan 

<img src="plan.png">

### revision of deploying a website in aws vm 

```
 1  yum install  git httpd -y 
    2  git clone https://github.com/yenchiah/project-website-template.git
    3  ls
    4  cp -rf project-website-template/*  /var/www/html/
    5  systemctl start httpd
    6  systemctl status  httpd
```

### changing resource of vm 

### we need to stop the vm 

### creating and confiugration is the new problem which leads to time 

<img src="prob1.png">

### solving above problem by implementing logics in ops 

<img src="prob2.png">

### devops tools for provisioning and configuration management

<img src="devops.png">

### intro to terraform and ansible 

<img src="devops1.png">

### getting started with cloud resources provisioning tool  terraform -- non cloud resources 

<img src="terraform.png">



