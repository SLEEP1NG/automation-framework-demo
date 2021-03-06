variable "subnet_id" {
  description = "The network for the delphix engine and target host"
}

variable "ami_name" {
  description = "Name of the congigured target AMI."
}

variable "vpc_id" {
  description = "VPC ID for the network."
}

variable "key_name" {
  description = "Name of the SSH keypair to use in AWS (do not include .pem extension)."
}

variable "env_tag" {
  description = "Environment Tag."
}

variable "db_url" {
  description = "Database Host URL."
}

variable "db_port" {
  description = "Database Host Port."
}

variable "db_name" {
  description = "KMS Encrypted value for Database Name."
}

variable "db_user" {
  description = "KMS Encrypted value for Database Username."
}

variable "db_pass" {
  description = "KMS Encrypted value for Database Password."
}

variable "jwt_secret" {
  description = "KMS Encrypted value for JWT Secret."
}

variable "jenkins_sg" {
  description = "Jenkins Security Group ID."
}


variable "owner" {}
variable "expiration" {}
variable "cost_center" {}
variable "project" {}
variable "environment" {}
variable "static_ips" {
  type  = "list"
}
