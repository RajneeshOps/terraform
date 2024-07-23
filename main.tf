resource "aws_instance" "mdl-server" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "module-server"
  }
}
