output "servers_output" {
  value = [for inst in aws_instance.k8s_instances : "export ${inst.tags.Name}='${inst.public_ip}'"]
}

output "msg1" {
  value = "to list out and add as env vars\nterraform output -json servers_output | jq -r '.[0,1,2,3]'\nterraform output -json servers_dns | jq -r '.[0,1,2,3]'"
}

output "servers_dns" {
  value = [for inst in aws_instance.k8s_instances : "export ${inst.tags.Name}DNS='${inst.public_dns}'"]
}