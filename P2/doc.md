# Part 2: K3s and Three Simple Applications

## Overview
This section involves deploying three simple web applications on the K3s cluster created in Part 1. Each application will be accessible based on the specified HOST when making requests to the IP address 192.168.56.110.

## Requirements
1. K3s cluster set up from Part 1.
2. Choose three web applications for deployment.

## Steps:

### 1. Configure K3s Cluster
Ensure that the K3s cluster set up in Part 1 is running and accessible. Verify the status of the nodes and pods on both machines.

```bash
# On Server machine (oelazzouS)
sudo k3s kubectl get nodes

# On ServerWorker machine (oelazzouSW)
sudo k3s kubectl get nodes
```

### 2. Write Deployment YAML
Create deployment YAML files for each of the three web applications. Define specifications such as replicas, image, and ports. Below is an example template for one application:

```yaml
# app1-deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: app1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app1
  template:
    metadata:
      labels:
        app: app1
    spec:
      containers:
      - name: app1
        image: your-docker-image-for-app1:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: app1
spec:
  selector:
    app: app1
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
```

Repeat this process for app2 and app3, adjusting the names, images, and ports accordingly.

### 3. Apply Deployments
Apply the deployment YAML files to deploy the applications on the K3s cluster.

```bash
# On Server machine (oelazzouS)
sudo k3s kubectl apply -f app1-deployment.yaml
sudo k3s kubectl apply -f app2-deployment.yaml
sudo k3s kubectl apply -f app3-deployment.yaml
```

### 4. Configure Ingress
Set up an Ingress resource to route traffic based on the specified HOST. Include the necessary rules to direct requests to the appropriate services.

```yaml
# ingress.yaml

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: main-ingress
spec:
  rules:
  - host: app1.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: app1
            port:
              number: 80
  - host: app2.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: app2
            port:
              number: 80
  - host: ""
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: app3
            port:
              number: 80
```

### 5. Verify Configuration
Test the web applications by accessing them through a web browser or using tools like curl. Ensure that each application responds correctly based on the specified HOST.

## Testing

### Web Browser Access
1. Open a web browser.
2. Enter the IP address 192.168.56.110 with the HOST app1.com, app2.com, or the default (no specified HOST).

### Curl Commands
Use curl commands to test the responses.

```bash
# For app1
curl -H "Host: app1.com" http://192.168.56.110

# For app2
curl -H "Host: app2.com" http://192.168.56.110

# For app3 (default)
curl http://192.168.56.110
```

## Conclusion
Part 2 is complete when you have successfully deployed three simple web applications on the K3s cluster, and they are accessible based on the specified HOST.

Continue to Part 3 for setting up K3d and Argo CD.
