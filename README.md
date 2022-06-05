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

### Install terraform on amazon linux 

[use_link](https://learn.hashicorp.com/tutorials/terraform/install-cli)

```
 11  sudo yum install -y yum-utils
   12  sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
   13  sudo yum -y install terraform
```

### how terraform will connect target AWS infra 

<img src="api.png">

### configure your terraform machine to access aws credentials 

```
aws  configure  
AWS Access Key ID [None]: 4VEXN
AWS Secret Access Key [None]: +sG/U0x30
Default region name [None]: us-east-2
Default output format [None]: 
```

### using HCL -- to write terraform scripts 

<img src="hcl.png">

### sample code to provision tf 

```
# provider means always -- what is your target cloud 
provider "aws" {
    region = "us-east-2" # name of Ohio region  
   # access_key =  "" we have already configured it using aws configure 
   # secret_key =  ""
}

#         name of resource  name of vm 
resource "aws_instance" "ashuvm1" {
    ami = "ami-0fa49cc9dc8d62c84"
    instance_type = "t2.micro"
    tags = {
        "Name" = "ashu-vm1-by-tf"
    }
    key_name = "ashuday2"
    
} 

```

## run script 

### terraform Init -- only time --

```
[ashu@ip-172-31-46-30 automation]$ terraform  init 

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v4.17.1...
- Installed hashicorp/aws v4.17.1 (signed by HashiCorp)

```

### lets check what is going to happen -- kind of dry-run 

```
terraform  plan 

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.ashuvm1 will be created
  + resource "aws_instance" "ashuvm1" {
      + ami                                  = "ami
```

### lets deploy it 

```
terraform  apply 

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.ashuvm1 will be created
  
  
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.ashuvm1: Creating...
aws_instance.ashuvm1: Still creating... [10s elapsed]
aws_instance.ashuvm1: Still creating... [20s elapsed]
aws_instance.ashuvm1: Still creating... [30s elapsed]
aws_instance.ashuvm1: Creation complete after 32s [id=i-0a9ad48e22cd90d1d]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

### terraform in one line 

<img src="terrform111.png">

### destroy  / delete things 

```
terraform destroy 
```

## starting Ansible -- configuration management tool 

<img src="ansible.png">

### check ansible is installed 

```
[root@ip-172-31-46-30 ~]# ansible --version 
ansible 2.9.23
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /bin/ansible
  python version = 2.7.18 (default, Jun 10 2021, 00:11:02) [GCC 7.3.1 20180712 (Red Hat 7.3.1-13)]
[root@ip-172-31-46-30 ~]# 


```

### creating vm and login to ec2-user 

```
fire@ashutoshhs-MacBook-Air Downloads % ssh  -i ashuday2.pem   ec2-user@3.14.81.200  
The authenticity of host '3.14.81.200 (3.14.81.200)' can't be established.
ECDSA key fingerprint is SHA256:7OEZCDwGpGVkNp+HemHbQCHxG4mvqmTjS+vHxD1MkGE.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '3.14.81.200' (ECDSA) to the list of known hosts.

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
2 package(s) needed for security, out of 6 available
Run "sudo yum update" to apply all updates.
-bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
[ec2-user@ip-172-31-37-223 ~]$ 
[ec2-user@ip-172-31-37-223 ~]$ 
[ec2-user@ip-172-31-37-223 ~]$ 

```

### ansible playbook and how to run it 

### apache.yaml 

```
---
- hosts: myvm 
  remote_user: ec2-user
  tasks:
  - name: lets run first command 
    command: date 
```

### ansible host inventory 

```
[myvm]
172.31.37.223
172.31.32.236
172.31.36.63
172.31.46.194
172.31.32.32
172.31.36.116
172.31.46.230
172.31.37.89
172.31.36.64
172.31.45.68
```

### how to run it 

```
[ashu@ip-172-31-46-30 ansible_tasks]$ ls
apache.yaml  target.txt
[ashu@ip-172-31-46-30 ansible_tasks]$ ansible-playbook -i target.txt  --ask-pass  apache.yaml 
```

