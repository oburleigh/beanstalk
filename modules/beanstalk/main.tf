resource "aws_elastic_beanstalk_environment" "flaskenv" {
  description            = var.description
  application            = var.application
  name                   = var.name
  version_label          = var.version_label
  solution_stack_name    = var.solution_stack_name
  tier                   = var.tier
  wait_for_ready_timeout = var.wait_for_ready_timeout

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.iam_instance_profile
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = var.load_balancer_type
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = var.elb_scheme
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpcid
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = var.security_groups
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", sort(var.elb_subnets))
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", sort(var.elb_subnets))
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = true
  }

  setting {
      namespace = "aws:elbv2:loadbalancer"
      name      = "ManagedSecurityGroup"
      value     = var.loadbalancer_managed_security_group
  }

  dynamic "setting" {
    for_each = var.app_env
    content {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = setting.key
      value     = setting.value
      resource  = ""
    }
  }
}
