# HCL_devsecops

## training plan 

<img src="plan.png">

###  revision 

<img src="rev.png">

### Ansible setup and its connection 

<img src="ansible.png">

### running ansible adhoc command 

<img src="adhoc.png">

### testing connection from ansible to target 

```
[ashu@ip-172-31-46-30 ansible-code]$ ansible  -i inventory myservers  -u ec2-user -m ping  -k 
SSH password: 
[WARNING]: Platform linux on host 172.31.46.194 is using the discovered Python interpreter at /usr/bin/python, but future
installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more information.
172.31.46.194 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"

```

### writing playbooks 

## Inventory file 

```
[myservers]
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

### first playbook 

```
---
- hosts: myservers
  remote_user: ec2-user 
  tasks: 
  - name: testing all the target servers
    command: date 
```

### running playbook 

```
 cd  ansible-code/
[ashu@ip-172-31-46-30 ansible-code]$ ls
apache.yaml  inventory
[ashu@ip-172-31-46-30 ansible-code]$ ansible-playbook -i inventory apache.yaml --ask-pass

SSH password: 

PLAY [myservers] ****************************************************************************************************

TASK [Gathering Facts] **********************************************

TASK [testing all the target servers] *******************************************************************************
changed: [172.31.32.32]
changed: [172.31.32.236]
changed: [172.31.37.223]
changed: [172.31.46.194]
changed: [172.31.36.63]
changed: [172.31.36.116]
changed: [172.31.46.230]
changed: [172.31.37.89]
changed: [172.31.36.64]
changed: [172.31.45.68]

PLAY RECAP **********************************************************************************************************
172.31.32.236              : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.31.32.32               : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.31.36.116              : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.31.36.63               : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.31.36.64               : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.31.37.223              : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.31.37.89               : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.31.45.68               : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.31.46.194              : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.31.46.230              : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

### playbook 2 

```
---
- hosts: myservers
  remote_user: ec2-user 
  tasks: 
  - name: testing all the target servers
    command: date 
    register: x # storing output using register 

  - name: showing output of date command 
    debug:
      msg: "{{ x }}"
```

### playbook 3

```
---
- hosts: myservers
  remote_user: ec2-user 
  tasks: 
  - name: testing all the target servers
    command: date 
    register: x # storing output using register 

  - name: showing output of date command 
    debug:
      msg: "{{ x.stdout }}"
```

### task 1 

## inventory 

```
[myservers]
172.31.37.223
172.31.32.236
172.31.36.63

[newvms]
172.31.46.194
172.31.32.32
172.31.36.116
172.31.46.230
172.31.37.89
172.31.36.64
172.31.45.68

```

### yaml playbook 

```
---
- hosts: myservers
  remote_user: ec2-user 
  tasks: 
  - name: testing all the target servers
    command: uptime
    register: z # storing output using register 

  - name: showing output of date command 
    debug:
      msg: "{{ z.stdout }}"
```

## run playbook 

```
 ec2.tf  terraform.tfstate  terraform.tfstate.backup
[ashu@ip-172-31-46-30 automation]$ cd  ansible-code/
[ashu@ip-172-31-46-30 ansible-code]$ ls
apache.yaml  inventory  test.yaml
[ashu@ip-172-31-46-30 ansible-code]$ ansible-playbook -i inventory  test.yaml  --ask-pass
SSH password: 

PLAY [myservers] **********************************************************************************

TASK [Gathering Facts] ****************************************************************************
[WARNING]: Platform linux on host 172.31.32.236 is using the discovered Python interpreter at
/usr/bin/python, but future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more
information.
ok: [172.31.32.236]
[WARNING]: Platform linux on host 172.31.36.63 is using the discovered Python interpreter at
/usr/bin/python, but future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more
information.
ok: [172.31.36.63]
[WARNING]: Platform linux on host 172.31.37.223 is using the discovered Python interpreter at
/usr/bin/python, but future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more
information.
ok: [172.31.37.223]

TASK [testing all the target servers] *************************************************************
changed: [172.31.32.236]
changed: [172.31.36.63]
changed: [172.31.37.223]

TASK [showing output of date command] *************************************************************
ok: [172.31.32.236] => {
    "msg": " 06:09:19 up  1:37,  1 user,  load average: 0.00, 0.01, 0.00"
}
ok: [172.31.37.223] => {
    "msg": " 06:09:19 up  1:37,  1 user,  load average: 0.00, 0.00, 0.00"
}
ok: [172.31.36.63] => {
    "msg": " 06:09:19 up  1:37,  1 user,  load average: 0.09, 0.03, 0.01"
}

PLAY RECAP ****************************************************************************************
172.31.32.236              : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.31.36.63               : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
172.31.37.223              : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```
### YAML 3 

```
---
- hosts: all
  remote_user: ec2-user 
  become: true
  tasks: 
  - name: testing all the target servers
    command: date 
    register: x # storing output using register 

  - name: showing output of date command 
    debug:
      msg: "{{ x.stdout }}"

  - name: installing apache httpd server 
    yum: 
      name: httpd
      state: present 
```

### running file 

```
ansible-playbook -i inventory  apache.yaml --ask-pass
```

### FInal apache server YAML and its targets 

```
---
- hosts: all
  remote_user: ec2-user 
  become: true
  tasks: 
  - name: testing all the target servers
    command: date 
    register: x # storing output using register 

  - name: showing output of date command 
    debug:
      msg: "{{ x.stdout }}"

  - name: installing apache httpd server 
    yum: 
      name: httpd
      state: present 

  - name: copy file from ansible machine to all the target machines
    copy: 
      src: ashu.html
      dest: /var/www/html/ashu.html # all target servers will have this file

  - name: starting httpd service 
    service:
      name: httpd
      state: started
```

### application deployment problem -- in History 

<img src="appprob1.png">

### app libs conflict 

<img src="conflict.png">

### introduction to hypervisor base vm 

<img src="hyper.png">

### understanding creating VM 

<img src="vm1.png">


### app vm need more resources than application need

<img src="need.png">

### vm are limited 

<img src="limited.png">

### welcome to containers and vm vs contianers 

<img src="cont.png">

### Docker being used to create containers 

<img src="cont2.png">

