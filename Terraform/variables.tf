variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}

# Added public key to my .zshrc file with `export TF_VAR_aws_ssh_pub_key="KEY"`
variable "aws_ssh_pub_key" {
  type      = string
  sensitive = true
}

variable "k8s_servers" {
  type    = set(string)
  default = ["control1", "worker1", "worker2", "worker3"]
}
