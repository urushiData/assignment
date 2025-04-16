variable "workstation_ip" {
  type = string
}

variable "vpc_id" {
  type = string
}

resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated" {
  key_name   = "terraform-generated-key"
  public_key = tls_private_key.generated.public_key_openssh
}

resource "local_file" "private_key" {
  content              = tls_private_key.generated.private_key_pem
  filename             = "${path.module}/terraform-generated-key.pem"
  file_permission      = "0400"
  directory_permission = "0700"
}

resource "aws_security_group" "app" {
  name        = "app-sg"
  description = "SG for LB, WEB, DB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.workstation_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.workstation_ip]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.168.0.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "assignment_sg"
  }
}

output "key_name" {
  value = aws_key_pair.generated.key_name
}

output "sg_id" {
  value = aws_security_group.app.id
}
