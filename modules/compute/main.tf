
# In modules/compute/main.tf

resource "aws_instance" "lms_ec2" {
  ami           = "ami-07caf09b362be10b8"  # Ensure this is the correct AMI for your region and instance type
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id  # Use the passed subnet ID variable in script

  tags = {
    Name = "LMSOncloudEC2Instance"
  }
}
