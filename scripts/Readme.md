The scripts will help setup a new kubernetes cluster on Azure. The cluster will be installed from scratch on provisioned VMs.

### Assumptions made:

- Azure cli is available
- az login is already run and is pointing to right account

### Installation

Installation is done by 2 scripts

- 01_setup_az.sh
- 02_setup_kube.sh

  Below is how the scripts work:

- **01_setup_az.sh**
- Read the env_sensitive.sh for subscription ID ( copy env_sensitive_template.sh to env_sensitive.sh and add subscription id)
- Read the env.sh for cluster setup variables - modify this file if you want to change the parameters
- Creates a resource group
- Generates ssh key if it doesnt exist in files_for_remote else uses existing one
- Sets up key in Azure
- Create virtual network with a subnet
- Creates a virtual machine to be used as master node. VM is:
- - 2 CPU, 8 GB RAM with 30 GB disk ( Standard_D2as_v4 )
- - with UbuntuLTS image
- - Running on spot instances set to max cost of 2c
- - It has a public IP with a fqdn setup - allows us to use fqdn instead of IP as IP changes every restart
- Generate 101_ssh.sh that makes it easy to login to master
- Save the environment variables into 00_env_gen.sh
- Creates N worker nodes specified in the environment
- **02_setup_kube.sh**
- Reads the environment variables from 00_env.sh and 00_env_gen.sh
- Copy all files from "files_for_remote" folder to master node
- Sets up master
- Sets up worker

### Working on the cluster

- run "sh 101_ssh.sh", this will connect to cluster
- kubectl get nodes - will show the nodes

### Things to try

- Connect from local machine
- - Open up port 6443 on k8masterNSG
- - Setup cluster, user and context locally and try to connect
