## How did I beat the CKA - and you will too

1. Get the right course: 

https://kodekloud.com/p/certified-kubernetes-administrator-with-practice-tests

Its also available in Udemy at:
https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests/

2. Watch and do every practice test from end-to-end, mostly using declarative ( YAML )

Use the below aliases during practice

3. Once done with all course content ( except lightning labs and mocktest ), do all practice tests again.  This time: 

- mostly using imperative commands
- use imperative to generate partital YAML if you need enhanced YAML to answer the question
- only use kubernetes documentation to answer the questions and bookmark one link form every topuc that you find comfortable
- Kubectl reference documentation is your friend, get very very familiar with that
https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands

Declarative is to understand the concepts better.  Imperative is to be quick for the exam.

4. Complete the json path course if you haven't

https://kodekloud.com/p/json-path-quiz


4. Do the mock tests ( not the lightning labs )

5. Do the lightning labs

6. Repeat 3,4,5, until you are comfortable ( dont worry you are doing for the 3rd or 4th time)

Its more expensive emotionally and financially to fail the exam multiple times

7. Try to do the 50 questions.  URL: 
https://dev.to/subodev/50-questions-for-ckad-and-cka-exam-3bjm

Solution available at: 
https://github.com/ravann/2021_cka_prep/tree/main/50_questions

Raise a github issue if you think the solution is not right.


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
- remove the rest of the characters from a position in line: Shift+d
- copy and paste : yy to copy; p to paste
- delete few lines : x dd ( x is the number of lines to delete)


## Bookmarks I used


