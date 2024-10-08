variable "aws_region" {
  description = "AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs."
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type for web and database servers."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "terraform_public_key"
  type   = string
}

variable "db_username" {
  description = "Database admin username."
  type        = string
}

variable "db_password" {
  description = "Database admin password."
  type        = string
  sensitive   = true
}
