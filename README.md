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

## Info about kubernetes k8s 

<img src="infok8s.png">

## k8s infra setup 

## minion / worker node setup 

### step 

```
 ssh -i  ashuday2.pem  ec2-user@3.145.129.211    
The authenticity of host '3.145.129.211 (3.145.129.211)' can't be established.
ECDSA key fingerprint is SHA256:6YgQgdI8NKosbE5eb0JvBKU3OX7LddRsFPg8yrLvcLc.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '3.145.129.211' (ECDSA) to the list of known hosts.

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
16 package(s) needed for security, out of 26 available
Run "sudo yum update" to apply all updates.
-bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
[ec2-user@ip-172-31-18-243 ~]$ 
[ec2-user@ip-172-31-18-243 ~]$ 
[ec2-user@ip-172-31-18-243 ~]$ sudo -i
[root@ip-172-31-18-243 ~]# hostnamectl set-hostname  ashu-worker
[root@ip-172-31-18-243 ~]# exit
logout
[ec2-user@ip-172-31-18-243 ~]$ sudo -i
[root@ashu-worker ~]# 


```

### step 2 : install and start docker 

```
 yum  install  docker  -y ; systemctl enable --now docker
 
```
##

```
cat  <<X  >/etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}

X

```

###
```
systemctl daemon-reload
systemctl restart docker

```
### step 3
### enable kernel bridge module 

```
[root@ashu-worker ~]# modprobe br_netfilter
[root@ashu-worker ~]# echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

```

### step 4 install kubelet 

```
cat  <<EOF  >/etc/yum.repos.d/kube.repo
[kube]
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
gpgcheck=0
EOF

```
### 

```
yum  install kubelet  kubeadm -y

```

###

```
 systemctl enable --now kubelet 
```

### How to configure k8s client --

```

[root@ip-172-31-46-30 ~]# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   154  100   154    0     0   1842      0 --:--:-- --:--:-- --:--:--  1855
100 43.5M  100 43.5M    0     0  48.8M      0 --:--:-- --:--:-- --:--:-- 79.3M
[root@ip-172-31-46-30 ~]# ls
kubectl  project-website-template
[root@ip-172-31-46-30 ~]# mv  kubectl  /usr/bin/
[root@ip-172-31-46-30 ~]# 
[root@ip-172-31-46-30 ~]# chmod +x  /usr/bin/kubectl 
[root@ip-172-31-46-30 ~]# 
[root@ip-172-31-46-30 ~]# 

```

### verify -- 

```
[ashu@ip-172-31-46-30 automation]$ kubectl  version --client -oyaml 
clientVersion:
  buildDate: "2022-05-24T12:26:19Z"
  compiler: gc
  gitCommit: 3ddd0f45aa91e2f30c70734b175631bec5b5825a
  gitTreeState: clean
  gitVersion: v1.24.1
  goVersion: go1.18.2
  major: "1"
  minor: "24"
  platform: linux/amd64
kustomizeVersion: v4.5.4

```

### how k8s client can connect to control plane 

<img src="cp.png">


### k8s master node components 

### kube-apiserver 

<img src="api.png">

### brain of k8s -- ETCD 

<img src="etcd.png">

### kube-schedular -- 

<img src="kube-sch.png">



### lets connect to master node

```
kubectl   get  nodes  --kubeconfig  admin.conf  
NAME            STATUS   ROLES           AGE   VERSION
anji-work       Ready    <none>          35m   v1.24.1
control-plane   Ready    control-plane   42m   v1.24.1
deepak-worker   Ready    <none>          36m   v1.24.1
divya-worker    Ready    <none>          38m   v1.24.1
gopal-worker    Ready    <none>          38m   v1.24.1
hema-worker     Ready    <none>          40m   v1.24.1
sai-worker      Ready    <none>          39m   v1.24.1
vamshi-worker   Ready    <none>          39m   v1.24.

```

###

```
 kubectl   cluster-info  --kubeconfig  admin.conf  
Kubernetes control plane is running at https://172.31.18.243:6443
CoreDNS is running at https://172.31.18.243:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
[ashu@ip-172-31-46-30 automation]$ 

```

### setup admin.conf 

```
 mkdir  ~/.kube
mkdir: cannot create directory ‘/home/ashu/.kube’: File exists
[ashu@ip-172-31-46-30 automation]$ 
[ashu@ip-172-31-46-30 automation]$ cp  -v  admin.conf   ~/.kube/config 
‘admin.conf’ -> ‘/home/ashu/.kube/config’
[ashu@ip-172-31-46-30 automation]$ 
[ashu@ip-172-31-46-30 automation]$ 
[ashu@ip-172-31-46-30 automation]$ kubectl  get  nodes
NAME            STATUS   ROLES           AGE   VERSION
anji-work       Ready    <none>          39m   v1.24.1
control-plane   Ready    control-plane   45m   v1.24.1
deepak-worker   Ready    <none>          39m   v1.24.1
divya-worker    Ready    <none>          42m   v1.2
```

### to deploy your container application in k8s check below image --

### we need docker image to be present on Image registry 

<img src="deploy1.png">

### lets deploy -- container image in k8s -- using POD concept 

<img src="pod1.png">

### write first pod file 

```
apiVersion: v1 # this apiserver version 
kind: Pod 
metadata:
  name: ashu-pod-1 # name of my pod 
spec: # info about containers 
  containers: 
  - name: ashuc1 # you can use same name 
    image: dockerashu/ashuhcl:appv1 # image from docker hub 
    ports: # image is having nginx server i.e using 80 
    - containerPort: 80 # optional field 

```

### now lets deploy it 

```
 kubectl  get  pods 
No resources found in default namespace.
[ashu@ip-172-31-46-30 automation]$ ls
admin.conf  ansible  docker  jenkins  k8s-deploy  tasks  terraform
[ashu@ip-172-31-46-30 automation]$ cd  k8s-deploy/
[ashu@ip-172-31-46-30 k8s-deploy]$ ls
ashupod1.yaml
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  create  -f ashupod1.yaml 
pod/ashu-pod-1 created
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  get  pods
NAME         READY   STATUS    RESTARTS   AGE
ashu-pod-1   1/1     Running   0          6s
[ashu@ip-172-31-46-30 k8s-deploy]$ 
```

### 

```
[root@control-plane kubernetes]# kubectl  get  pods  -o wide 
NAME           READY   STATUS    RESTARTS   AGE     IP               NODE            NOMINATED NODE   READINESS GATES
ashu-pod-1     1/1     Running   0          8m4s    192.168.140.65   anji-work       <none>           <none>
deepak-pod-1   1/1     Running   0          5m24s   192.168.83.2     sai-worker      <none>           <none>
divya-pod-1    1/1     Running   0          12m     192.168.47.65    hema-worker     <none>           <none>
gopal-pod-1    1/1     Running   0          11m     192.168.90.65    gopal-worker    <none>           <none>
hema-pod-1     1/1     Running   0          2m25s   192.168.97.131   deepak-worker   <none>           <none>
sai-pod-1      1/1     Running   0          9m45s   192.168.21.193   vamshi-worker   <none>           <none>
vamshi-pod-1   1/1     Running   0          7m45s   192.168.97.130   deepak-worker   <none>           <none>
```

### explore more details about pod 

### single pod info 

```
kubectl  get pod ashu-pod-1     -o wide 
\NAME         READY   STATUS    RESTARTS   AGE   IP               NODE        NOMINATED NODE   READINESS GATES
ashu-pod-1   1/1     Running   0          12m   192.168.140.65   anji-work   <none>           <none>
```
### describe pod 

```
kubectl  describe pod ashu-pod-1 
Name:         ashu-pod-1
Namespace:    default
Priority:     0
Node:         anji-work/172.31.38.23
Start Time:   Fri, 10 Jun 2022 12:09:54 +0000
Labels:       <none>
Annotations:  cni.projectcalico.org/containerID: df005fed1b11eef6d701fee43c2cac87e7ebdd1732ad44ee2e3e238db919dfe8
              cni.projectcalico.org/podIP: 192.168.140.65/32
              cni.projectcalico.org/podIPs: 192.168.140.65/32
Status:       Running
IP:           192.168.140.65
IPs:
  IP:  192.168.140.65
Containers:
  ashuc1:
    Container ID:   containerd://2505051a9395887681dab53ce290578c046aeb3d83e427bf6d81434c037b3817
    Image:          dockerashu/ashuhcl:appv1
    Image ID:       docker.io/dockerashu/ashuhcl@sha256:ff6788544523f831bdadd5d376074db3dc49052401e5009e02547992361d44a7
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Fri, 10 Jun 2022 12:09:58 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-8xhvj (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-8xhvj:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  14m   default-scheduler  Successfully assigned default/ashu-pod-1 to anji-work
  Normal  Pulling    14m   kubelet            Pulling image "dockerashu/ashuhcl:appv1"
  Normal  Pulled     14m   kubelet            Successfully pulled image "dockerashu/ashuhcl:appv1" in 2.987347197s
  Normal  Created    14m   kubelet            Created container ashuc1
  Normal  Started    14m   kubelet            Started container ashuc1

```

### accessing container shell 

```
kubectl  exec -it ashu-pod-1   -- bash
root@ashu-pod-1:/# 
root@ashu-pod-1:/# cd  /usr/share/nginx/html/
root@ashu-pod-1:/usr/share/nginx/html# ls
50x.html  health.html  index.html
root@ashu-pod-1:/usr/share/nginx/html# exit
exit
```

### checking logs 

```
 kubectl  logs  ashu-pod-1 
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/06/10 12:09:58 [notice] 1#1: using the "epoll" event method
2022/06/10 12:09:58 [notice] 1#1: nginx/1.21.6
2022/06/10 12:09:58 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/06/10 12:09:58 [notice] 1#1: OS: Linux 5.10.109-104.500.amzn2.x86_64
2022/06/10 12:09:58 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/06/10 12:09:58 [notice] 1#1: start worker processes
2022/06/10 12:09:58 [notice] 1#1: start worker process 31
```
### delete pod 

```
kubectl  delete  pod    ashu-pod-1 
pod "ashu-pod-1" deleted
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  delete  -f  ashupod1.yaml
```

