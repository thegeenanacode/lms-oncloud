# In modules/networking/outputs.tf

output "subnet_id" {
  value = aws_subnet.lms_subnet.id
  description = "The ID of the subnet"
}
