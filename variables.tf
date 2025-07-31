variable "ami_id" {
  default = "ami-0447a12f28fddb066"
}

variable "subnet_id" {
  default = "subnet-08bedab1563d4fd48"
}

variable "vpc_id" {
  default = "vpc-055e91f61cb3e4b20"
}

variable "security_group_id" {
  default = "sg-00a932d53b6449e9f"
}

variable "alert_email" {
  type        = string
  description = "Email to receive CloudWatch alarm notifications"
}
