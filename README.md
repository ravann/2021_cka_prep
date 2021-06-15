## Preparing for the CKA exam

1. Get the right course: 

There are a number of materials on the internet that will help you prepare for the CKA.  The below course from KodeKloud teaches the concepts and then the actual exam material.  They have a number of practice tests that will help you solidify your understanding.

https://kodekloud.com/p/certified-kubernetes-administrator-with-practice-tests

Its also available in Udemy at:
https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests/

2. Watch every video and do every practice test from end-to-end, mostly using declarative ( YAML )

Use the below aliases during practice

3. Once done with all course content ( except lightning labs and mocktests ), do all practice tests again.  This time: 

- mostly using imperative commands
- use imperative to generate partital YAML if you need enhanced YAML to answer the question
- only use kubernetes documentation to answer the questions and bookmark one link form every topuc that you find comfortable
- Kubectl reference documentation is your friend, get very very familiar with that
https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands

Declarative is to understand the concepts better.  Imperative is to be quick for the exam.

4. Do the mock tests ( not the lightning labs )

5. Do the lightning labs

6. Repeat 3,4,5, until you are comfortable ( dont worry you are doing for the 3rd or 4th time)

Its more expensive emotionally and financially to fail the exam multiple times

7. Try to do the 50 questions.  URL: 
https://dev.to/subodev/50-questions-for-ckad-and-cka-exam-3bjm

Solution available at: 
https://github.com/ravann/2021_cka_prep/tree/main/50_questions

Raise a github issue if you think the solution is not right.

8. Review the tasks in the documentation 

https://kubernetes.io/docs/tasks/


## Practice with the fixed set of aliases so its easy to work with them in the exam

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

Most common shortcuts that helps speed up are: 
- deploy : deployment
- svc : service
- rs : replicaset
- ds : daemonsets
- pv : persistent volume
- pvc : persistent volumne claim
- csr : certificate signing request


## VI Short cuts

- move to end of line : $
- move to start of file :  :1
- remove a word: dw
- remove a line: dd
- remove the rest of the characters from a position in line: shift+d
- copy and paste : yy to copy; p to paste
- delete few lines : x dd ( x is the number of lines to delete)


## Some useful bookmarks


- https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#configure-all-key-value-pairs-in-a-configmap-as-container-environment-variables
- https://kubernetes.io/docs/concepts/configuration/secret/#use-case-as-container-environment-variables
- https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
- https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
- https://kubernetes.io/docs/reference/access-authn-authz/rbac/
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
- https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/
- https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
- https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/quota-memory-cpu-namespace/
- https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/
- https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
- https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
- https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/
- https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/
- https://kubernetes.io/docs/tasks/extend-kubernetes/configure-multiple-schedulers/
- https://kubernetes.io/docs/concepts/storage/volumes/#hostpath
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/
- https://kubernetes.io/docs/concepts/services-networking/service/
- https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/#steps-for-the-first-control-plane-node
- https://kubernetes.io/docs/concepts/services-networking/network-policies/
- https://kubernetes.io/docs/concepts/services-networking/ingress/
- https://kubernetes.github.io/ingress-nginx/deploy/
- https://kubernetes.github.io/ingress-nginx/examples/rewrite/
- https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
- https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
- https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/

