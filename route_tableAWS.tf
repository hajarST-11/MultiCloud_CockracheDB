# =====================
# AWS Route Table
# =====================
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  # Internet access
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  # Routes to Azure VNet subnets via VPN Gateway
  route {
    cidr_block = "172.10.0.0/24"
    gateway_id = aws_vpn_gateway.vgw.id
  }

  route {
    cidr_block = "172.10.1.0/24"
    gateway_id = aws_vpn_gateway.vgw.id
  }

  # ✅ Removed 172.31.0.0/16 — EC2 is now in 10.10.x.x, not default VPC

  tags = {
    Name = "rt-my-vpc"
  }
}

# ✅ Added — Associates route table to subnet (was missing!)
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}
