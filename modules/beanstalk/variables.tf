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
  description = "The type of load balancer for your environment"
}

variable "elb_scheme" {
  type        = string
  description = ""
}

variable "instance_type" {
  type        = string
  description = "The instance type used to run your application in an Elastic Beanstalk environment"
}

variable "iam_instance_profile" {
  type        = string
  description = "An instance profile enables AWS Identity and Access Management (IAM) users and AWS services to access temporary security credentials to make AWS API calls"
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
  description = "Assign an existing security group to your environment’s load balancer, instead of creating a new one"
}

variable "elb_subnets" {
  description = <<EOF
                "The IDs of the subnet or subnets for the elastic load balancer. 
                If you have multiple subnets, specify the value as a single comma-separated string of subnet IDs"
                EOF
}

variable "vpcid" {
  type = string
  description = "The ID for your Amazon VPC."
}

variable "security_groups" {
  description = "A list of security groups to attach to the load balancer"
}

variable "loadbalancer_security_groups" {
  description = "A list of security groups to attach to the load balancer"
}

#=========================Auto Scaling==============================

variable "autoscale_min" {
  type        = number
  default     = 2
  description = "Minumum instances to launch"
}

variable "autoscale_max" {
  type        = number
  default     = 3
  description = "Maximum instances to launch"
}

variable "autoscale_measure_name" {
  type        = string
  default     = "CPUUtilization"
  description = "Metric used for your Auto Scaling trigger"
}

variable "autoscale_statistic" {
  type        = string
  default     = "Average"
  description = "Statistic the trigger should use, such as Average"
}

variable "autoscale_unit" {
  type        = string
  default     = "Percent"
  description = "Unit for the trigger measurement, such as Bytes"
}

variable "autoscale_lower_bound" {
  type        = number
  default     = 20
  description = "Minimum level of autoscale metric to remove an instance"
}

variable "autoscale_lower_increment" {
  type        = number
  default     = -1
  description = "How many Amazon EC2 instances to remove when performing a scaling activity."
}

variable "autoscale_upper_bound" {
  type        = number
  default     = 80
  description = "Maximum level of autoscale metric to add an instance"
}

variable "autoscale_upper_increment" {
  type        = number
  default     = 1
  description = "How many Amazon EC2 instances to add when performing a scaling activity"
}
