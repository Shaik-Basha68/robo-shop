variable  "sg_name" {
  type        = list(string)
  description = "Name of the security group"
}


variable "Project_name" {
  type        = string
  description = "Name of the project"
}

variable "Environment" {
  type        = string
  description = "Environment name"
}

variable "sg_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the security group"
}   


