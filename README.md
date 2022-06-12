# HCL_devsecops

## training plan 

<img src="plan.png">

### CI CD -- devops tools

<img src="cicd.png">

### jenkins comparasion with azure devops 

<img src="az.png">

### after CI lets write CD step there 

```
kubectl  create  deployment ashufinal-deploy --image=dockerashu/ashuhcl:appfinal  --port 80  --dry-run=client -o yaml >finaldeploy.yaml 
```

### deploy it

```
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl create -f finaldeploy.yaml 
deployment.apps/ashufinal-deploy created
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  get deploy 
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
ashufinal-deploy   1/1     1            1           4s
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  get po
NAME                                READY   STATUS    RESTARTS   AGE
ashufinal-deploy-784f87c4bc-68r4t   1/1     Running   0          7s
```
### creating service 

```
kubectl  get  deploy 
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
ashufinal-deploy   1/1     1            1           8m18s
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  expose deploy  ashufinal-deploy  --type NodePort --port 80 --name ashulb1234 --dry-run=client -o yaml >finallb.yaml 
[ashu@ip-172-31-46-30 k8s-deploy]$ ls
ashudep.yaml  ashupod1.yaml  deployment1.yaml  finallb.yaml  secureapp.yaml
ashulb1.yaml  ashupod2.yaml  finaldeploy.yaml  profile
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  create -f  finallb.yaml 
service/ashulb1234 created
[ashu@ip-172-31-46-30 k8s-deploy]$ kubectl  get  svc
NAME         TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
ashulb1234   NodePort   10.111.122.63   <none>        80:31051/TCP   3s
[ashu@ip-172-31-46-30 k8s-deploy]$ 

```
### rollout deploy 

```
kubectl  rollout restart  deploy ashufinal-deploy
```

### introducing security in devops model -- devsecops 

<img src="devsecops.png">

### introduction to security pipeline 

<img src="secpipe.png">

## SAST

### Sonarqube -- 

[URLdocs](https://www.sonarqube.org/)

### sonarqube can take code from various sources 

<img src="sonar.png">

### security tools and trade 

<img src="sectools.png">

### OWASP docs 

[docslink](https://owasp.org/www-community/Free_for_Open_Source_Application_Security_Tools)

### SAST and DAST 

<img src="tools.png">



