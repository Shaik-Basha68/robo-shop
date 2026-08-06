variable  "Project_name" {
  type        = string
}

variable  "Environment" {
  type        = string
}

variable "instance_type" {
  type        = string
  validation {
    condition     = contains(["t2.micro", "t2.small", "t3.medium"], var.instance_type)
    error_message = "instance_type must be either 't2.micro', 't2.small', or 't2.medium'."
  }
}

variable "ami" {
  type        = string
}   

variable "instance_tags" {
  type        = map(string)
  default     = {}
}