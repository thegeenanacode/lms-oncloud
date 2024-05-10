# In modules/networking/outputs.tf

output "public_subnet_id" {
  value = aws_subnet.lms_public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.lms_private_subnet.id
}
