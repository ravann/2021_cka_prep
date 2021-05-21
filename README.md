### Course to follow

https://kodekloud.com/p/certified-kubernetes-administrator-with-practice-tests

Its also available in Udemy at:
https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests/


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

### Shortcuts for objects

```sh
kubectl api-resources
```

Most common aliases that helps are: 
- deploy : deployment
- svc : service
- rs : replicaset
- ds : daemonsets
- pv : persistent volume
- pvc : persistent volumne claim
- csr : certificate signing request


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

### Imperative commands

Imperative commands are very helpful during the exam.  Ensure you use imperative commands as much as possible.

Understand and appreciate the kubectl reference commands

https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands

