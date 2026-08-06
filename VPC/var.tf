variable cidr_block {
  type        = string
  description = "description"
}

variable vpc_tags {
  type        = map
  default     = {}
  description = "description"
}

variable Project_name {
  type        = string
  description = "description"
}

variable Environment {
  type        = string
  description = "description"
}

variable public_subnet_cidrs {
  type        = list(string)
  description = "description"
}

variable private_subnet_cidrs {
  type        = list(string)
  description = "description"
}

variable database_subnet_cidrs {
  type        = list(string)
  description = "description"
}

variable "subnet_tags" {
  type        = map
  default     = {}
  description = "description"
} 
