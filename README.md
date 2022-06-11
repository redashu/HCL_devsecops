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



