# Security group for the ALB
resource "aws_security_group" "lb" {
  name        = "SG_load_balancer"
  description = "Load Balancer security group"
  vpc_id      = aws_vpc.default.id
}

# Allow traffic from public internet
resource "aws_security_group_rule" "lb-ingress" {
  description = "allow traffic from internet to load balancer"
  type        = "ingress"

  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb.id
}

# Allow outbound traffic from the service
resource "aws_security_group_rule" "lb-egress" {
  description = "allow all outbound traffic"
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.lb.id
}

# Security group for Application
resource "aws_security_group" "application" {
  name        = "SG_applicaton"
  description = "Application security group"
  vpc_id      = aws_vpc.default.id
}

# Allow traffic from the the load balancer to application
resource "aws_security_group_rule" "backend-ingress" {
  description = "allow traffic from load balancer"
  type        = "ingress"

  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb.id
  security_group_id        = aws_security_group.application.id
}

# Allow outbound traffic from the application
resource "aws_security_group_rule" "application-egress" {
  description = "allow all outbound traffic"
  type        = "egress"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.application.id
}

# Security group for Database
resource "aws_security_group" "database" {
  name        = "SG_database"
  description = "Database security group"
  vpc_id      = aws_vpc.default.id
}

# Allow traffic from the the load balancer to application
resource "aws_security_group_rule" "database-ingress" {
  description = "allow traffic from application"
  type        = "ingress"

  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.application.id
  security_group_id        = aws_security_group.database.id
}