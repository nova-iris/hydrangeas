output "control_id" {
  value = module.controlplane.instance_id
}

output "worker_node_ids" {
  value = module.worker_nodes[*].instance_id
}
