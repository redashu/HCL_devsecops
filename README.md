# HCL_devsecops

## training plan 

<img src="plan.png">

## create POD YAML and deploy in kubernetes 

### generate Pod YAML -- automatically 

```
kubectl run  ashupod2 --image=dockerashu/ashuhcl:appv1 --port 80 --dry-run=client -o yaml  
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ashupod2
  name: ashupod2
spec:

===

 kubectl run  ashupod2 --image=dockerashu/ashuhcl:appv1 --port 80 --dry-run=client -o yaml   >ashupod2.yaml 

```

### deploy yaml 

```
kubectl  create  -f  ashupod2.yaml 
pod/ashupod2 created
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  get  pods
NAME       READY   STATUS    RESTARTS   AGE
ashupod2   1/1     Running   0          20s
hemapod2   1/1     Running   0          8s
saipod2    1/1     Running   0          5m27s
```
### getting started with k8s networking 

### pod ip can't be reached by public users 

<img src="podip.png">

### k8s internal LB will present in every worker node 

<img src="lb.png">

### creating service 

<img src="svc.png">

```
kubectl  expose  pod  ashupod2  --type NodePort --port 80 --name ashuinternal-lb 
service/ashuinternal-lb exposed
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  get  service 
NAME              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
ashuinternal-lb   NodePort    10.105.137.162   <none>        80:31464/TCP   7s
kubernetes        ClusterIP   10.96.0.1        <none>        443/TCP        19h
```

### to access application public users can use any worker IP 

<img src="access.png">


### Deployment resource in kubernetes 

<img src="dep.png">

### creating deployment --

```
kubectl  create  deployment  ashu-app --image=dockerashu/ashuhcl:appv1 --port 80 --dry-run=client -o yaml  >deployment1.yaml 
```

### deploy it 

```
 kubectl  create -f  deployment1.yaml 
deployment.apps/ashu-app created
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl   get  deployment  
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
ashu-app   1/1     1            1           6s
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl   get  po
NAME                        READY   STATUS    RESTARTS   AGE
ashu-app-698f6f66b8-ggt5k   1/1     Running   0          15s
[ashu@ip-172-31-46-30 k8s-deploy]$ 

```

### recreation check 

```
 kubectl  delete pod ashu-app-698f6f66b8-ggt5k
pod "ashu-app-698f6f66b8-ggt5k" deleted
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  get pods
NAME                           READY   STATUS    RESTARTS   AGE
anji-app-84494dd457-9zflq      1/1     Running   0          3m55s
ashu-app-698f6f66b8-64tnb      1/1     Running   0          3s
```

### now creating nodeport service using deployment expose 

```
 kubectl  expose deployment  ashu-app  --type NodePort --port 80 --name ashulb1 --dry-run=client  -o yaml >ashulb1.yaml 
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  get  svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   17m
[ashu@ip-172-31-46-30 k8s-deploy]$ ls
ashulb1.yaml  ashupod1.yaml  ashupod2.yaml  deployment1.yaml
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  create -f ashulb1.yaml 
service/ashulb1 created
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  get  svc 
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
ashulb1      NodePort    10.97.248.250   <none>        80:30689/TCP   3s
kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP        17m

```
### scaling in pod 

<img src="podscale.png">

## horizental 
```
 kubectl   scale deploy  ashu-app  --replicas=3
deployment.apps/ashu-app scaled
```

### k8s service will be using label of pod to find 

<img src="labels.png">

### deploy multiple files using kubectl 

```
kubectl  create  -f deployment1.yaml -f ashulb1.yaml 
deployment.apps/ashu-app created
service/ashulb1 created
[ashu@ip-172-31-46-30 k8s-deploy]$ 
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  get deploy 
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
ashu-app   1/1     1            1           5s
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
ashulb1      NodePort    10.99.228.139   <none>        80:31648/TCP   7s
```





