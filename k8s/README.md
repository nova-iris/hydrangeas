# Deploy a simple Kubernetes cluster

### Cluster structure:

- Single Master node
- Worker nodes: Can be configure when provisioning nodes via terraform.
- version: Tested with 1.32 (default). can be configure in ansible.
- CRI: containerd
- CNI: Flannel
- Pod network CIDR: 10.244.0.16


### How to deploy

1. Provision infras by terraform first. Ansible inventory file will be created in ansible folder.
2. Go to ansible folder.
3. User can change cluster config in `ansible/group_vars/all/main.yml`
4. Run the script `setup_cluster.sh`
