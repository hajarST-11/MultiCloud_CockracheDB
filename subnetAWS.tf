# =====================
# AWS Subnet
# =====================
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.aws_subnet_cidr
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true   # ✅ Added — needed for EC2 public access

  tags = {
    Name = "my-subnet-01"
  }
}
