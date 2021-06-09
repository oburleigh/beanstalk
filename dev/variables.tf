variable "region" {
  default     = "eu-west-2"
  type        = string
  description = "The region you want to deploy the infrastructure in"
}

variable "env_vars" {
  type        = map(string)
  default     = {}
  description = "Map of custom ENV variables to be provided to the application running on Elastic Beanstalk, e.g. env_vars = { DB_USER = 'admin' DB_PASS = 'xxxxxx' }"
}

variable "db_password" {
  type        = string
  description = "Password to RDS DB"
  sensitive   = true
}

variable "db_allocated_storage" {
  type = number
}

variable "db_engine" {
  type        = string
  description = ""
}

variable "db_engine_version" {
  type        = string
  description = ""
}

variable "db_instance_class" {
  type        = string
  description = ""
}

variable "db_name" {
  type        = string
  description = ""
}

variable "db_username" {
  type        = string
  description = ""
}

variable "db_parameter_group_name" {
  type        = string
  description = ""
}

variable "db_skip_final_snapshot" {
  type        = bool
  description = ""
}

variable "db_port" {
  type        = string
  description = ""
}

variable "s3_bucket" {
  type        = string
  description = ""
}

variable "s3_key" {
  type        = string
  description = ""
}

variable "s3_source" {
  type        = string
  description = ""
}

variable "bse_description" {
  type        = string
  description = ""
}

variable "bse_name" {
  type        = string
  description = ""
}

variable "bse_tier" {
  type        = string
  description = ""
}

variable "bse_wait_for_ready_timeout" {
  type        = string
  description = ""
}

variable "bse_load_balancer_type" {
  type        = string
  description = ""
}

variable "bse_elb_scheme" {
  type        = string
  description = ""
}

variable "bse_instance_type" {
  type        = string
  description = ""
}

variable "bse_iam_instance_profile" {
  type        = string
  description = ""
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR for the VPC"
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "CIDR for the Public Subnet"
}

variable "private_app_subnet_cidr_block" {
  type        = string
  description = "CIDR for the Private Subnet"
}

variable "private_db_subnet_cidr_block" {
  type        = string
  description = "CIDR for the Private Subnet"
}

variable "map_public_ip_on_launch" {
  default     = true
  type        = bool
  description = "Subnet to be mapped to Public IP"
}

variable "map_public_ip_on_launch_private" {
  default     = false
  type        = bool
  description = "Subnet to be mapped to Public IP"

}

variable "eb_autoscale_min" {
  type        = number
  default     = 2
  description = "Minumum instances to launch"
}

variable "eb_autoscale_max" {
  type        = number
  default     = 3
  description = "Maximum instances to launch"
}

variable "eb_autoscale_measure_name" {
  type        = string
  default     = "CPUUtilization"
  description = "Metric used for your Auto Scaling trigger"
}

variable "eb_autoscale_statistic" {
  type        = string
  default     = "Average"
  description = "Statistic the trigger should use, such as Average"
}

variable "eb_autoscale_unit" {
  type        = string
  default     = "Percent"
  description = "Unit for the trigger measurement, such as Bytes"
}

variable "eb_autoscale_lower_bound" {
  type        = number
  default     = 20
  description = "Minimum level of autoscale metric to remove an instance"
}

variable "eb_autoscale_lower_increment" {
  type        = number
  default     = -1
  description = "How many Amazon EC2 instances to remove when performing a scaling activity."
}

variable "eb_autoscale_upper_bound" {
  type        = number
  default     = 80
  description = "Maximum level of autoscale metric to add an instance"
}

variable "eb_autoscale_upper_increment" {
  type        = number
  default     = 1
  description = "How many Amazon EC2 instances to add when performing a scaling activity"
}
