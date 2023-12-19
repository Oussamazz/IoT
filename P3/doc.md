### Description P3:
To complete Part 3 of your project, you need to set up K3D and Argo CD on your virtual machine, create namespaces, and deploy applications with continuous integration. Below are detailed steps to guide you through the process:

### Step 1: Install K3D and Docker

Create a script (let's call it `install_k3d.sh`) to install K3D and Docker. Make the script executable and run it.

```bash
#!/bin/bash

# Install Docker
sudo apt-get update
sudo apt-get install -y docker.io

# Install K3D
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
```

```bash
chmod +x install_k3d.sh
./install_k3d.sh
```

### Step 2: Create K3D Cluster

```bash
# Create a K3D cluster named "myk3dcluster"
k3d cluster create myk3dcluster
```

### Step 3: Install Argo CD

```bash
# Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Create an Argo CD admin password
kubectl -n argocd patch secret argocd-secret -p '{"data": {"admin.password": null, "admin.passwordMtime": null}}'

# Retrieve the password
echo "Argo CD Admin Password: $(kubectl -n argocd get secret argocd-secret -o jsonpath='{.data.admin\.password}' | base64 --decode)"
```

### Step 4: Create Namespaces

```bash
# Create namespaces
kubectl create namespace dev
```

### Step 5: Create Application and Deployment

1. Create a public GitHub repository and push your configuration files (`deploy.yaml`, `deployment.yaml`, etc.) to it.

2. Create an application in Argo CD for the dev namespace.

```bash
# Set up Argo CD app
argocd app create my-app \
  --repo https://github.com/yourusername/your-repo.git \
  --path dev \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace dev \
  --sync-policy automated
```

### Step 6: Configure GitHub Repository for CI

Follow the instructions to tag your application versions (v1 and v2) and update the GitHub repository.

### Step 7: Verify Application Deployment

```bash
# Check namespaces
kubectl get ns

# Check pods in the dev namespace
kubectl get pods -n dev
```

### Step 8: Update Application Version

```bash
# Update application version in deploy.yaml
sed -i 's/wil42\/playground:v1/wil42\/playground:v2/g' deploy.yaml

# Git add, commit, and push changes
git add deploy.yaml
git commit -m "Update application version to v2"
git push origin master
```

### Step 9: Verify Application Update

```bash
# Check deployment.yaml for v2
cat deployment.yaml | grep v2

# Verify application status
curl http://localhost:8888/
```

### Bonus Part (if mandatory part is perfect):

1. Install GitLab locally using Helm or any method you prefer.
2. Configure GitLab to work with your cluster.
3. Create a dedicated namespace named "gitlab."
4. Ensure everything from Part 3 works with your local GitLab.
5. Organize bonus work in a new folder named "bonus" at the root of your repository.

### Submission and Peer-Evaluation:

Organize your repository as specified, with mandatory parts in folders p1, p2, and p3. Add the bonus part in a folder named "bonus." Verify the directory structure before submission.
