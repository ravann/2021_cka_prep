### Course to follow

https://kodekloud.com/p/certified-kubernetes-administrator-with-practice-tests

Its also available in Udemy at:
https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests/

### Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run)

```sh
kubectl run nginx --image=nginx --dry-run=client -o yaml
```

### Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)

```sh
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml
```

### Generate Deployment YAML file (-o yaml). Don't create it(--dry-run) with 4 Replicas (--replicas=4)

```sh
kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml
```

### Practice with the fixed set of aliases so its easy to work with them in the exam

```sh
alias a=alias
a k="kubectl"
a ka="kubectl apply -f"
a kapi="kubectl api-resources"
a kauth="kubectl auth"
a kc="kubectl create "
a kdel="kubectl delete "
a kdes="kubectl describe "
a kdr="k drain"
a ke="kubectl edit"
a kg="kubectl get "
a kl="kubectl label"
a klog="kubectl logs"
a kr="kubectl run "
a kt="kubectl taint nodes"
a ktop="kubectl top"
a kns="kubectl config set-context $(kubectl config current-context) --namespace  "
```

### Aliases for objects

https://www.lightnetics.com/topic/10248/kubernetes-aliases-for-objects

```sh
kubectl api-resources
```

### VI Short cuts

- search
- search and replace a word
- replcae a line with another line
- replace a word with another word
- Move to end of line
- move to start of line
- move to end of file
- move to start of file
- copy and paste
- delete few lines

### Imperative commands

#### PODS

```sh
# Create a pod
kubectl run redis --image=redis

# Dont create a pod but generate YAML
kubectl run redis --image=redis --dry-run=client -o yaml
```

#### Services

```sh
# Create pod and expose
kr custom-nginx --image=nginx --expose=true --port=8080

kubectl expose pod nginx --port=80 --name nginx-service --node-port=30080

# This will automatically use the pod's labels as selectors
kubectl expose pod redis --port=6379 --name redis-service

kubectl create service clusterip my-svc --clusterip="None" -o yaml --dry-run=client | kubectl set selector --local -f - 'environment=qa' -o yaml | kubectl create -f -

```
