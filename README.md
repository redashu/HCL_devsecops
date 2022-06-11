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


