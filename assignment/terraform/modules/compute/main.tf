variable "subnet_id" {
  type = string
}

variable "sg_id" {
  type = string
}

variable "key_name" {
  type = string
}

resource "aws_instance" "lb" {
  ami                         = "ami-0dd97ebb907cf9366"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  private_ip                  = "192.168.0.11"
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name

  tags = {
    Name = "LB"
  }
}

resource "aws_instance" "web" {
  ami                         = "ami-0dd97ebb907cf9366"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  private_ip                  = "192.168.0.12"
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name

  tags = {
    Name = "WEB"
  }
}

resource "aws_instance" "db" {
  ami                         = "ami-0dd97ebb907cf9366"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  private_ip                  = "192.168.0.13"
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name

  tags = {
    Name = "DB"
  }
}

output "lb_public_ip" {
  value = aws_instance.lb.public_ip
}

output "web_public_ip" {
  value = aws_instance.web.public_ip
}

output "db_public_ip" {
  value = aws_instance.db.public_ip
}
