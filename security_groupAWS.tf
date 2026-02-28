# =====================
# AWS Security Group for EC2
# =====================
resource "aws_security_group" "ec2_sg" {
  name        = "launch-wizard-2"
  description = "Allow SSH and ICMP"
  vpc_id      = aws_vpc.main.id

  # SSH from anywhere
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ICMP from anywhere (including Azure)
  ingress {
    description = "ICMP - All"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

# =====================
# AWS Network ACL
# =====================
resource "aws_network_acl" "main" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.main.id]

  # Allow all inbound
  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # Allow inbound from Azure
  ingress {
    rule_no    = 101
    action     = "allow"
    protocol   = "6"  # TCP
    cidr_block = var.azure_vnet_cidr
    from_port  = 0
    to_port    = 65535
  }

  # Allow all outbound
  egress {
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # Allow outbound to Azure
  egress {
    rule_no    = 102
    action     = "allow"
    protocol   = "6"  # TCP
    cidr_block = var.azure_vnet_cidr
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "nacl-my-vpc"
  }
}
