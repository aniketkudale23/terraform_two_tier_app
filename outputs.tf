output "frontend_public_ips" {
  description = "Public IPs of the frontend servers."
  value       = aws_instance.frontend.*.public_ip
}

output "backend_private_ip" {
  description = "Private IP of the backend database server."
  value       = aws_instance.backend.private_ip
}

output "vpc_id" {
  description = "VPC ID."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets."
  value       = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  description = "IDs of private subnets."
  value       = aws_subnet.private.*.id
}