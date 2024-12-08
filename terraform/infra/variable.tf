variable "env" {
  description = "This is env variable like dev,stg,prod"
  type = string
}

variable "instance_type" {
  description = "This is Instance type like t2.micro, t2.medium etc.."
  type = string
}

variable "instance_count" {
  description = "This contain the instance count for the every enviroment"
  type = number
}

# variable "ami_id" {
#   description = "This is ami image id for instance"
#   type = string
# }

variable "instance_volume_size" {
  description = "This contain the size of every instance should be"
  type = number
}

variable "aws_instance_os_distro" {
  description = "Defines the operating system image filter for selecting an appropriate AMI (e.g., Ubuntu 20.04)."
  type        = string
  default     = "ubuntu/images/hvm-ssd/*amd64*"
}

variable "aws_ami_owners" {
  description = "The owner ID of the AMI to use. Default is Canonical (for Ubuntu AMIs)."
  type        = string
  default     = "099720109477"
}