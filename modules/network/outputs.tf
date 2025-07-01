output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "public_subnet_id_az2" {
  value = aws_subnet.public_az2.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}
