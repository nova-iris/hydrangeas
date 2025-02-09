# Install kubeadm, containerd on all nodes
ansible-playbook playbooks/install_kubeadm.yml

# setup master node
ansible-playbook playbooks/init_k8s_master.yml

# join the cluster from worker nodes
ansible-playbook playbooks/join_workers.yml