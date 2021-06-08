variable "password" {
  type = string
  description = "Password to RDS DB"
  sensitive = true
}

variable "allocated_storage" {
  type = number
} 

variable "engine" {
  type = string
  description = ""
}

variable "engine_version" {
  type = string
  description = ""
}

variable "instance_class" {
  type = string
  description = ""
}

variable "name" {
  type = string
  description = ""
}

variable "username" {
  type = string
  description = ""
}

variable "parameter_group_name" {
  type = string
  description = ""
}

variable "skip_final_snapshot" {
  type = bool
  description = ""
}

variable "vpc_security_group_ids" {
  description = ""
}

variable "db_subnet_group_name" {
  description = ""
}
