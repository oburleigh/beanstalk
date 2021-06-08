data "aws_iam_role" "example" {
  name = "aws-elasticbeanstalk-service-role"
}

data "aws_elastic_beanstalk_solution_stack" "python" {
  most_recent = true
  name_regex  = "^64bit Amazon Linux (.*) Python 3.8$"
}

data "aws_availability_zones" "main" {
  state = "available"
}
