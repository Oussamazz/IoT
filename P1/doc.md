# Part 1: K3s and Vagrant

## Overview
This section focuses on setting up two virtual machines using Vagrant and deploying K3s in different modes on each machine. The machines will be named and configured according to the specified requirements.

## Requirements
1. Install Vagrant on your local machine.
2. Choose a Linux distribution for your virtual machines.

## Steps

### 1. Set up Vagrantfile
Create a Vagrantfile to define the configuration for the two virtual machines. The Vagrantfile should include the following specifications:

```ruby
# Vagrantfile

Vagrant.configure(2) do |config|
  # Configuration for Server machine
  config.vm.define "oelazzouS" do |control|
    control.vm.hostname = "oelazzouS"
    control.vm.network "private_network", type: "dhcp"
    # Additional configurations for Server machine...
  end

  # Configuration for ServerWorker machine
  config.vm.define "oelazzouSW" do |control|
    control.vm.hostname = "oelazzouSW"
    control.vm.network "private_network", type: "dhcp"
    # Additional configurations for ServerWorker machine...
  end
end
```

Adjust the configuration based on your chosen Linux distribution.

### 2. Install K3s
In this step, you'll install K3s on both virtual machines. Follow these guidelines:

- **Server Machine (oelazzouS):** Install K3s in controller mode.
- **ServerWorker Machine (oelazzouSW):** Install K3s in agent mode.

Use a provisioning script within the Vagrantfile to automate the installation process.

### 3. Verify Configuration
Ensure that the virtual machines are correctly configured with K3s installed. SSH into each machine and run the following commands:

```bash
# On Server machine (oelazzouS)
sudo k3s kubectl get nodes

# On ServerWorker machine (oelazzouSW)
sudo k3s kubectl get nodes
```

Both machines should be listed and in a ready state.

## Testing

### SSH Access
Verify that you can SSH into both machines without a password prompt.

```bash
# SSH into Server machine
ssh oelazzouS

# SSH into ServerWorker machine
ssh oelazzouSW
```

### K3s Cluster
Test the K3s cluster setup by running basic Kubernetes commands.

```bash
# On Server machine (oelazzouS)
sudo k3s kubectl get pods --all-namespaces

# On ServerWorker machine (oelazzouSW)
sudo k3s kubectl get pods --all-namespaces
```

Both machines should show the expected Kubernetes pods.

## Conclusion
Part 1 is complete when you have successfully set up a K3s cluster using Vagrant with two machines: one in controller mode and one in agent mode.

Continue to Part 2 for deploying three simple applications on your K3s cluster.
