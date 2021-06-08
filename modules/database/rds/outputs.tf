output "instance_address" {
  value       = join("", aws_db_instance.default.*.address)
  description = "DNS address of the instance"
}
