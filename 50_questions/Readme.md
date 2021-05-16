These questions are taken from:
https://dev.to/subodev/50-questions-for-ckad-and-cka-exam-3bjm

Practice in the original location if you dont want to see the solutions along with questions.

### Set the alias

```sh
alias k='kubectl'
alias ka='kubectl apply -f'
alias kc='kubectl create'
alias kdel='kubectl delete'
alias kdes='kubectl describe'
alias ke='kubectl edit'
alias kg='kubectl get'
alias kr='kubectl run'
```

1. Create a new pod with the nginx image.

```sh
kr nginx-pod --image=nginx
```

2. Create a new pod with the name redis and with the image redis:1.99.

```sh
kr redis --image=redis:1.99
```

3. Identify the problem with the pod.

```sh
k logs redis
```

Shows the image doesnt exist.

4. Rectify the problem with the pod and wait until the pod is ready and healthy.

```sh
kdel pod redis
kr redis --image=redis
```

5. Create a new replicaset rs-1 using image nginx with labels tier:frontend and selectors as tier:frontend. Create 3 replicas for the same.

```sh
kc deploy rs-1 --image=nginx --replicas=3 --dry-run=client -o yaml > rs-1.yaml
```

Modify the rs-1.yaml by :

1. change the kind to ReplicaSet
2. Delete the strategy
3. Delete the status
4. Add labels and modify selectors

```yml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  creationTimestamp: null
  labels:
    app: rs-1
    tier: frontend # Not sure if this is required but no harm
  name: rs-1
spec:
  replicas: 3
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      creationTimestamp: null
      labels:
        tier: frontend
    spec:
      containers:
        - image: nginx
          name: nginx
```

6. Scale the above replicaset to 5 replicas.

```sh
k scale rs rs-1 --replicas=5
```

7. Update the image of the above replicaset to use nginx:alpine image.

```sh
k set image rs rs-1 nginx=nginx:alpine
```

8. Scale down the replicaset to 2 replicas.

```sh
k scale rs rs-1 --replicas=2
```

9. Create a new deployment deploy-1 using image busybox with 3 replicas and command sleep 3600.

```sh
kc deploy deploy-1 --image=busybox --replicas=3 -- sleep 3600
```

10. Update the image of the above deployment with image ubuntu.

```sh
# In the imperative commands, image name is the container name.
k set image deploy deploy-1 busybox=ubuntu
```

11. Create a namespace finance.

```sh
kc ns finance
```

12. Create a pod redis01 using image redis in the finance namespace.

```sh
kr redis01 --image=redis -n finance
```

13. Deploy a redis02 pod using the redis:alpine image with the labels set to tier=db.

```sh
kr redis02 --image=redis:alpine --labels="tier=db"
```

14. Create a service redis-service to expose the redis02 application within the cluster on port 6379.

```sh
k expose pod redis02 --port=6379 --name=redis-service
```

15. Create a new pod called custom-nginx using the nginx image and expose it on container port 8080.

```sh
kr custom-nginx --image=nginx --expose=true --port=8080
```

16. Create a pod called httpd using the image httpd:alpine in the default namespace. Next, create a service of type ClusterIP by the same name (httpd). The target port for the service should be 80.

```sh
kr httpd --image=httpd:alpine --expose=true --port=80
```

17. Create a pod with the ubuntu image to run a container to sleep for 5000 seconds.

```sh
kr ubuntu-sleeper --image=ubuntu -- sleep 5000
```

18. Create a new ConfigMap for the webapp-color pod. Set key-value pairs as COLOR=blue.

```sh
kc cm webapp-color --from-literal=COLOR=blue
```

19. Create a deployment nginx01 using nginx image, which has environment variable CREATED_BY with value octocat.

We can do this 2 ways. Imperative:

```sh
kc deploy nginx01 --image=nginx
k set env deploy nginx02 CREATED_BY=octocat
```

Mixed:

```sh
kc deploy nginx01 --image=nginx --dry-run=client -o yaml > deploy-nginx01.yaml
```

Edit the yaml and add env to container

20. Verify the environment variable in the containers of the above deployment.

```sh
kdes deploy nginx01
```

21. Create a new config map db-config with key-value pairs as:

- db-host = "localhost.example.com"
- db-port = 3306
- db-name = "kubernetes-objects"

```sh
kc cm db-config --from-literal=db-host=localhost.example.com --from-literal=db-port=3306 --from-literal=db-name=kubernetes-objects
```

22. Mount the config map db-config in the deployment ubuntu01 with image ubuntu which has 2 replicas.

```sh
kc deploy ubuntu01 --image=ubuntu --replicas=2 --dry-run=client -o yaml -- sleep 6000 > deploy-ubuntu01.yaml
```

Edit the yaml to add volumes and volumeMounts

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: ubuntu01
  name: ubuntu01
spec:
  replicas: 2
  selector:
    matchLabels:
      app: ubuntu01
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: ubuntu01
    spec:
      containers:
        - command:
            - sleep
            - "6000"
          image: ubuntu
          name: ubuntu
          volumeMounts:
            - name: db-conf
              mountPath: /config
      volumes:
        - name: db-conf
          configMap:
            name: db-config
```

```sh
k exec -it ubuntu01-67f487c488-h9mnd -- ls /config/
# db-host  db-name  db-port
k exec ubuntu01-67f487c488-h9mnd -- cat /config/db-host # We actually dont need it
# localhost.example.com
```

23. Create a deployment named multi-con-01, which has two containers, one container uses nginx image and has port 80 exposed. Mount the config map db-config as environment variable. Create the second container in the same deployment with image ubuntu, keep the container alive using the command sleep 5000 and mount the config map in db-config with different keys where the new keys are mapped as:

- db-host --> DB_URL
- db-port --> DB_PORT
- db-name --> DB_NAME

```sh
kc deploy multi-con-01 --image=ubuntu --dry-run=client -o yaml -- sleep 5000 > deploy-multi-con-01.yaml
```

Edit the yaml file to add env section

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: multi-con-01
  name: multi-con-01
spec:
  replicas: 1
  selector:
    matchLabels:
      app: multi-con-01
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: multi-con-01
    spec:
      containers:
        - name: nginx
          image: nginx
        - command:
            - sleep
            - "5000"
          image: ubuntu
          name: ubuntu
          env:
            - name: DB_URL
              valueFrom:
                configMapKeyRef:
                  name: db-config
                  key: db-host
            - name: DB_PORT
              valueFrom:
                configMapKeyRef:
                  name: db-config
                  key: db-port
            - name: DB_NAME
              valueFrom:
                configMapKeyRef:
                  name: db-config
                  key: db-name
```

24. Create an opaque secret named db-creds with following key value pairs:

- db_user=root
- db_password=pass404
- db_role=admin

```sh
kc secret generic db-creds --from-literal=db_user=root --from-literal=db_password=pass404 --from-literal=db_role=admin
```

25. Mount the secret db-creds in the deployment multi-con-01 [created in (23)] as environment variables in the ubuntu container with the same keys as mentioned in the secret.

Since the keys are not changing, we can add envFrom section to the ubuntu container

```yaml
envFrom:
  - secretRef:
      name: db-creds
```

Check the variables in the container

```sh
k exec multi-con-01-84d6848d-45gn9 -c ubuntu -- env | grep -i db
# db_user=root
# DB_URL=localhost.example.com
# DB_PORT=3306
# DB_NAME=kubernetes-objects
# db_password=pass404
# db_role=admin
```

26. Create a pod ubuntu02 with image ubuntu and run the command sleep 3400 as user 1001.

```sh
kr ubuntu02 --image=ubuntu --dry-run=client -o yaml  -- sleep 3400 > pod-ubuntu02.yaml
```

Add security context section

```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ubuntu02
  name: ubuntu02
spec:
  securityContext:
    runAsUser: 1001
  containers:
    - args:
        - sleep
        - "3400"
      image: ubuntu
      name: ubuntu02
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```

27. Create a pod ubuntu03 with image ubuntu and add capabilities for SYS_TIME to each container. Run the command date -s '01JAN 2020 10:00:00 to verify if it is successful.

```sh
kr ubuntu03 --image=ubuntu --dry-run=client -o yaml  -- sleep 3400 > pod-ubuntu03.yaml
```

Edit the yaml to add capabilities to the container

```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ubuntu03
  name: ubuntu03
spec:
  containers:
    - args:
        - sleep
        - "3400"
      image: ubuntu
      name: ubuntu03
      securityContext:
        capabilities:
          add: ["SYS_TIME"]
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```

28. Taint one of the worker nodes in your cluster with the following property, mode=maintainance:NoSchedule. Create a pod nginx02 with image nginx:alpine and ensure the pod runs on the tainted node as above.

Taint and label the node

```sh
k taint node worker2 mode=maintainance:NoSchedule
k label node worker2 special=true
```

Use these in the pod definition

```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx02
  name: nginx02
spec:
  containers:
    - image: nginx:alpine
      name: nginx02
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  tolerations:
    - key: "mode"
      operator: "Equal"
      value: "maintainance"
      effect: "NoSchedule"
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: special
                operator: Exists
```

29. Create a pod box0 with image busybox and command sleep 30; touch /tmp/debug; sleep 30; rm /tmp/debug. The pod should not be ready until the file /tmp/debug is available in the pod. If the file doesn't exist, the pod must restart.

TBC

30. This is for CKAD - CKA doesnt have probes

31. This is a multistage problem:

- Create a deployment deploy01 with image nginx with port 80 exposed.
- Update the deployment with image nginx:dev and make sure you record the execution of this action.
- If the deployment in step b is unsuccessful, rollback the deployment to the previous state by setting any fields explicitly.
- If the nginx deployment is in a healthy state, scale the deployment to run 3 replicas, also record this execution for audit-keeping.
- Display the history of deployment deploy-01 and store it in file /opt/answers/31.txt.

TBD

```sh
kc deploy deploy01 --image=nginx --port=80
k set image deploy deploy01 nginx=nginx:dev --record
k rollout history deploy deploy01
k rollout undo deploy deploy01
k rollout history deploy deploy01
k scale deploy deploy01 --replicas=3 --record
k rollout history deploy deploy01 > /opt/answers/31.txt
```

Issues: History not recorded properly

32. CKAD

33. CKAD

34. CKAD

35. Create a Persistent Volume deploy-history which makes the storage available on each worker nodes at /tmp/deployment. Make sure it has the default provisioner of your cluster assigned. Label the Persistent Volume with audit: true, tier: middleware. The persistent volume must have a capacity of 2 GB.

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: deploy-history
  labels:
    audit: "true" # Notice the double quotes
    tier: middleware
spec:
  storageClassName: manual
  capacity:
    storage: 2Gi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/tmp/deployment"
```

36. Create a Persistent Volume persistent-data which uses a storage class name persistent and is of type hostPath which stores the data on /tmp/persistent on worker nodes. The persistent volume must have a capacity of 2 GB.

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: persistent-data
spec:
  storageClassName: persistent
  capacity:
    storage: 2Gi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/tmp/persistent"
```

37. Create a Persistent Volume my-personal-data which uses a storage class name persistent and is of type hostPath which stores the data on /tmp/pii on worker nodes. The persistent volume must have a capacity of 2 GB. Since this will store personal data, make sure you can identify the persistent volume using the labels security: high, type: pii, audit: true.

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-personal-data
  labels:
    audit: "true"
    security: high
    type: pii
spec:
  storageClassName: persistent
  capacity:
    storage: 2Gi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/tmp/pii"
```

38. Create a Persistent Volume Claim to bind to persistent volume which uses storage class persistent and requests 2 GB capacity.

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-persistent
spec:
  storageClassName: persistent
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```

39. Create a Persistent Volume Claim to bind to a PV which ensures that the personal and private data is secure. Ensure that this PVC will bind to a PV of type pii.

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-personal-data-claim
spec:
  storageClassName: persistent
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```

Note: The first pvc bound to the first created pv. Not sure if its the design or accident.

40. Create a PVC such that it will bind to a PV that is qualified for middleware applications.

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: deploy-history-claim
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```

41. Create a deployment deploy02 with image busybox, mount one of the PVC from above such that it will store logs in the /tmp/deployment directory. The containers of the deployment must:

- a] Create a file in /tmp/deployment with the same name as the pod name with .txt extension.
- b] Run the command i=0; while true; do; echo "$i $(date)" >> /tmp/deployment/<podname>.txt && sleep 60 ; done to the log file.
  Hint: You can use init-containers, environment variables to achieve this.
- c] Ensure there are 5 replicas of the deployment.
- d] Ensure you can see the log files created and populated with data in /tmp/deployment directory on the scheduled worker nodes.

Note: this question is 2 parts:

- Get the volume mounted
- Ensure the pod name is available to code
  Below yaml incorporates both

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: deploy02
  name: deploy02
spec:
  replicas: 5
  selector:
    matchLabels:
      app: deploy02
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: deploy02
    spec:
      containers:
        - image: busybox
          name: busybox
          command: ["/bin/sh"]
          args:
            [
              "-c",
              "i=0; while true; do echo $i $(date) >> /tmp/deployment/${POD_NAME}.txt && sleep 60; i=$((i+1)); done",
            ]
          env:
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
          volumeMounts:
            - name: deployment-volume
              mountPath: /tmp/deployment
      volumes:
        - name: deployment-volume
          persistentVolumeClaim:
            claimName: deploy-history-claim
```

42. CKAD?

Is anti-affinity part of the CKA course?

43. Create 3 pods nginx05, redis05, and httpd05 with images nginx, redis, and httpd respectively. Attach a sidecar debug container of image busybox to each of them. The security team has enforced the application team to limit the communication between unnecessary pods. Ensure that only the following communication is allowed between pods:

- Allow:
- - nginx05 <--> redis05
- - nginx05 <--> httpd05
- Deny:
- - httpd05 <-/-> redis05
- - redis05 <-/-> rest of the world
- - nginx05 <-/-> the rest of the world

Identify a possible information flow in this system. Write the information flow in the format End-User::Pod1::Pod2::Pod3.

### Solution

Flow:
httpd can communicate with nginx but not with redis
nginx can communicate with redis
rest of the world can only communicate with httpd

=> the flow is: End-User::httpd::nginx::redis

To be precise the flow must be:

- rest of the world ->
- ( ingress at 80 ) **httpd** (egress at port 80) ->
- **nginx** (egress at port 6379) ->
- (ingress at port 6379) **redis**

[Full YAML]()

44.
