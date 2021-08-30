## ping
```
ping 115.239.211.112 -c 10 | awk '{ print $0"\t" strftime("%Y-%m-%d %H:%M:%S",systime())}' 

ping 115.239.211.112 | awk '{ print $0"\t" strftime("%Y-%m-%d %H:%M:%S",systime()); fflush()}' >> outIP.info & 
```

## k8s yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: laping
  namespace: logging
  labels:
    k8s-app: laping
spec:
  replicas: 1
  selector:
    matchLabels:
      k8s-app: laping
  template:
    metadata:
      labels:
        k8s-app: laping
    spec:	
      containers:	  
      - name: laping
        image: mark/alpine:3.9-ping
        imagePullPolicy: IfNotPresent
        resources:
          limits:
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 100Mi		
        ports:
          - containerPort: 2020
        env:
        - name: FLUENT_ELASTICSEARCH_HOST
          value: "10.100.63.24"
        volumeMounts:
        - name: varlibdockercontainers
          mountPath: /data/logs/ping/
      nodeSelector:
        beta.kubernetes.io/laping-ready: "true"
      volumes:
      - name: varlibdockercontainers
        hostPath:
          path: /data/logs/ping/
```
label
```
kubectl label nodes 10.100.63.20   beta.kubernetes.io/laping-ready=true
kubectl -n logging get pods
```
