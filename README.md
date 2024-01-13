# Inception of Things (IoT) Project

## Overview

This project focuses on implementing Kubernetes (K8s) using K3s and K3d in a virtualized environment. Divided into parts, it covers VM setup, K3s configuration, application deployment, and more.

![Wallpaper](wallpaper.jpg)

## Parts

1. **Part 1: K3s and Vagrant** Done
   - Set up two VMs with Vagrant.
   - Install K3s in controller and agent modes.

2. **Part 2: K3s and Three Simple Applications** Done
   - Deploy three web apps on a single VM with K3s.
   - Access apps based on specified hosts and IP addresses.

3. **Part 3: K3d and Argo CD** (working on it ...)
   - Install K3D, Docker.
   - Set up namespaces for Argo CD.
   - Create a CI pipeline for app deployment from GitHub.

## Bonus (working on it ...)

- **Bonus Part (Optional):**
   - Add GitLab to the project.
   - Ensure compatibility with the local cluster.
