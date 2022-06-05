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



