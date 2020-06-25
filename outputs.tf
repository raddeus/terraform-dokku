output "public_ip" {
  value = aws_eip.web.public_ip
}

output "public_dns" {
  value = aws_eip.web.public_dns
}