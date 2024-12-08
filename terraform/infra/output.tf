output "instance_public_ips" {
  description = "This is used to show all env's servers public ips"
  value = aws_instance.my_instance[*].public_ip
}