variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "key_name" {}
variable "private_key_path" {}

variable "github_organization" {}
variable "github_repository" {}
variable "github_branch" {}
variable "github_token" {}

variable "db_password" {}

variable "app_name" {}

variable "secret_key_base" {}

variable "aws_region" {
  type = "string"
  default = "us-east-1"
}

variable "network_address_space" {
  type = "string"
  default = "10.1.0.0/16"
}

variable "subnet1_address_space" {
  type = "string"
  default = "10.1.0.0/24"
}

variable "subnet2_address_space" {
  type = "string"
  default = "10.1.1.0/24"
}
