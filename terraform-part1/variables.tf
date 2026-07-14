variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "AWS EC2 Key Pair Name"
  type        = string
}

variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
}
