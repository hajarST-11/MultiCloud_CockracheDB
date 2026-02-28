# =====================
# AWS EC2 Instance
# =====================
resource "aws_instance" "main" {
  ami                    = var.aws_ami
  instance_type          = "t2.nano"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               =  "moncle" 

  tags = {
    Name = "aws2"
  }
}
