#===============Core Variables===============
map_public_ip_on_launch         = true
map_public_ip_on_launch_private = false
vpc_cidr_block                  = "10.0.0.0/16"
public_subnet_cidr_block        = "10.0.1.0/24"
private_app_subnet_cidr_block   = "10.0.2.0/24"
private_db_subnet_cidr_block    = "10.0.3.0/24"

#===============RDS Variables================

db_allocated_storage    = 20
db_engine               = "postgres"
db_engine_version       = "12.5"
db_instance_class       = "db.t2.micro"
db_name                 = "database2"
db_port                 = "5432"
db_username             = "postgres"
db_parameter_group_name = "default.postgres12"
db_skip_final_snapshot  = true

#================S3 Variables=================

s3_bucket = "flask-bucket-2020194"
s3_key    = "flask"
s3_source = "../build/flaskapp.zip"

#=============Beanstalk Variables=============

bse_description            = "my test"
bse_name                   = "flaskEnv"
bse_tier                   = "WebServer"
bse_wait_for_ready_timeout = "20m"
bse_load_balancer_type     = "application"
bse_elb_scheme             = "public"
bse_instance_type          = "t2.micro"
bse_iam_instance_profile   = "aws-elasticbeanstalk-ec2-role"
