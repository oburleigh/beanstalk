variable "description" {
  type        = string
  description = ""
}

variable "name" {
  type        = string
  description = ""
}

variable "tier" {
  type        = string
  description = ""
}

variable "wait_for_ready_timeout" {
  type        = string
  description = ""
}

variable "load_balancer_type" {
  type        = string
  description = ""
}

variable "elb_scheme" {
  type        = string
  description = ""
}

variable "instance_type" {
  type        = string
  description = ""
}

variable "iam_instance_profile" {
  type        = string
  description = ""
}

variable "application" {
  type        = string
  description = ""
}

variable "solution_stack_name" {
  type        = string
  description = ""
}

variable "version_label" {
  type        = string
  description = ""
}

variable "app_env" {
  description = ""
}

variable "loadbalancer_managed_security_group" {
}

variable "elb_subnets" {
}

variable "vpcid" {
}

variable "security_groups" {
}
