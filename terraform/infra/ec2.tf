# Fetch the AMI for the instance based on specified filters
data "aws_ami" "ubuntu" {
    owners      = [var.aws_ami_owners]
    most_recent = true

    filter {
        name   = "name"
        values = [var.aws_instance_os_distro]
    }

    filter {
        name   = "state"
        values = ["available"]
    }
}


resource "aws_key_pair" "my_key_pair" {
  key_name = "${var.env}-devops-key"
  public_key = file("devops-key.pub")
}

resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "my_sg" {
  name = "${var.env}-devops-sg"
  description = "This is security for every instance"
  vpc_id = aws_default_vpc.default.id

  ingress {
    description = "Allow access to port 22 for ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    description = "Allow access to port 80 for http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    description = "Allow access to port 443 for https"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    description = "Allow access to every port for outgoing"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }


  tags = {
    Name = "${var.env}-devops-sg"
    Enviroment = var.env
  }

}


resource "aws_instance" "my_instance" {
    count = var.instance_count
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = aws_key_pair.my_key_pair.key_name
    security_groups = [aws_security_group.my_sg.name]

    root_block_device {
      volume_size = var.instance_volume_size
      volume_type = "gp3"
    }

    tags = {
      Name = "${var.env}-devops-instance"
      Enviroment = var.env
    }
}