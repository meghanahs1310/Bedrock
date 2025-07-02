resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = { Name = "bedrock-vpc" }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags              = { Name = "private-subnet-${count.index}" }
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}
