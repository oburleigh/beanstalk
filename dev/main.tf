provider "aws" {
  region = var.region
}

resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
}

resource "aws_subnet" "public" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.main.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id                  = aws_vpc.default.id
}

# resource "aws_subnet" "private_app" {
#   count                   = 2
#   availability_zone       = data.aws_availability_zones.main.names[count.index]
#   cidr_block              = "10.0.${count.index + 100}.0/24"
#   map_public_ip_on_launch = var.map_public_ip_on_launch_private
#   vpc_id                  = aws_vpc.default.id
# }

resource "aws_subnet" "private_db" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.main.names[count.index]
  cidr_block              = "10.0.${count.index + 200}.0/24"
  map_public_ip_on_launch = var.map_public_ip_on_launch_private
  vpc_id                  = aws_vpc.default.id
}

resource "aws_db_subnet_group" "default" {
  name       = "rds"
  subnet_ids = aws_subnet.private_db[*].id
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.default.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  count          = 2
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}

# resource "aws_route_table" "private_app" {
#   vpc_id = aws_vpc.default.id
# }

# resource "aws_route_table_association" "private_app" {
#   count          = 2
#   route_table_id = aws_route_table.private_app.id
#   subnet_id      = aws_subnet.private_app[count.index].id
# }

resource "aws_route_table" "private_db" {
  vpc_id = aws_vpc.default.id
}

resource "aws_route_table_association" "private_db" {
  count          = 2
  route_table_id = aws_route_table.private_db.id
  subnet_id      = aws_subnet.private_db[count.index].id
}

module "rds" {
  source                 = "../modules/database/rds"
  allocated_storage      = var.db_allocated_storage
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = var.db_parameter_group_name
  skip_final_snapshot    = var.db_skip_final_snapshot
  vpc_security_group_ids = [aws_security_group.database.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
}

locals {
  env_vars = {
    "RDS_HOSTNAME" = module.rds.instance_address
    "RDS_USERNAME" = var.db_username
    "RDS_PASSWORD" = var.db_password
    "RDS_PORT"     = var.db_port
  }
}

resource "aws_s3_bucket" "default" {
  bucket = var.s3_bucket

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "flask_latest" {
  bucket = aws_s3_bucket.default.id
  key    = var.s3_key
  source = var.s3_source
}

resource "aws_elastic_beanstalk_application" "flask" {
  name        = "flaskApp"
  description = "Flask App"

  appversion_lifecycle {
    service_role          = data.aws_iam_role.example.arn
    max_count             = 128
    delete_source_from_s3 = true
  }
}

module "beanstalkenv" {
  source                 = "../modules/beanstalk"
  description            = var.bse_description
  application            = aws_elastic_beanstalk_application.flask.name
  name                   = var.bse_name
  version_label          = aws_elastic_beanstalk_application_version.default.name
  solution_stack_name    = data.aws_elastic_beanstalk_solution_stack.python.name
  tier                   = var.bse_tier
  wait_for_ready_timeout = var.bse_wait_for_ready_timeout
  load_balancer_type     = var.bse_load_balancer_type
  elb_scheme             = var.bse_elb_scheme
  instance_type          = var.bse_instance_type
  elb_subnets            = aws_subnet.public.*.id
  security_groups        = aws_security_group.application.id
  # app_subnets = aws_subnet.private_app.*.id
  loadbalancer_managed_security_group = aws_security_group.lb.id
  loadbalancer_security_groups        = [aws_security_group.lb.id, aws_security_group.application.id]
  iam_instance_profile                = var.bse_iam_instance_profile
  app_env                             = local.env_vars
  vpcid                               = aws_vpc.default.id

  autoscale_min             = var.eb_autoscale_min
  autoscale_max             = var.eb_autoscale_max
  autoscale_measure_name    = var.eb_autoscale_measure_name
  autoscale_statistic       = var.eb_autoscale_statistic
  autoscale_unit            = var.eb_autoscale_unit
  autoscale_lower_bound     = var.eb_autoscale_lower_bound
  autoscale_lower_increment = var.eb_autoscale_lower_increment
  autoscale_upper_bound     = var.eb_autoscale_upper_bound
  autoscale_upper_increment = var.eb_autoscale_upper_increment
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "flask-version"
  application = aws_elastic_beanstalk_application.flask.name
  bucket      = aws_s3_bucket_object.flask_latest.bucket
  key         = aws_s3_bucket_object.flask_latest.key
}
