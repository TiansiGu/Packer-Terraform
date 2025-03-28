# Bastion Host Public DNS
output "bastion_public_dns" {
  description = "Public DNS of the bastion host instance"
  value       = aws_instance.bastion.public_dns
}

# EC2 instances Private DNS
output "ec2_amazon_linux_private_ip" {
  description = "Private IP Address of Amazon Linux EC2 instances"
  value = aws_instance.ec2-amazon-linux[*].private_ip
}

# Custom EC2 instances Private DNS
output "ec2_ubuntu_private_ip" {
  description = "Private IP Address of Ubuntu EC2 instances"
  value = aws_instance.ec2-ubuntu[*].private_ip
}