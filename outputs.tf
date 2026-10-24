output "public_ip" {
  description = "Public IP address of web server"
  value = aws_instance.web.public_ip
}
