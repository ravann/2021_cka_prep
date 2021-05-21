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
alias k=kubectl
alias ka="kubectl apply -f"
alias kc="kubectl create"
alias kdel="kubectl delete"
alias kdes="kubectl describe"
alias kg="kubectl get"
alias kr="kubectl run"
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
- Move to end of line : $
- move to start of line :
- move to end of file :
- move to start of file :
- copy and paste : yy to copy; p to paste
- delete few lines : x dd ( x is the number of lines to delete)

### Using tmux

```sh
tmux # Launches tmux interface
tmux split-window -h # splits the window horizontally - I use this as  my monitor is wide
# This will bring focus to the right side pane
alias sp="tmux select-pane -t 0"
sp
# This will bring focus to left side pane
alias sp="tmux select-pane -t 1"
# sp command can be used to switch between panes
```

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
