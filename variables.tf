variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Default region"
}

variable "instance_type" {
    default = "t2.micro"
    type = string
    description = "Instance type"
}
variable "environment" {
    description = "Environment name (dev, staging, production)"
    type = string
}

variable "ami" {
    default = "ami-063fb82b183efe67d"
    description = "This is the default AMI"
}