variable "elb_type" {
  type        = string
  validation {
    condition     = contains(["application", "network"], var.elb_type)
    error_message = "elb_type must be either 'application' or 'network'."
  }
}

variable "elb_internal" {
  type        = bool
}

variable "elb_tags" {
  type        = map
  default     = {}
  description = "elb_tags is a map of tags to add to the ELB. These tags will be merged with the common tags."
}

variable  "Project_name" {
  type        = string
}

variable "Environment" {
  type        = string
}