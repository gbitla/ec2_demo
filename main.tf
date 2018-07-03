provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  #count         = 3
  ami                    = "ami-2d39803a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance-sg.id}"]

  user_data = <<-EOF
            #!/bin/bash
            echo "Hello, World" > index.html
            nohup busybox httpd -f -p 8080 &
            EOF

  tags {
    Name = "terraform_example_node"
  }
}

resource "aws_security_group" "instance-sg" {
  name = "terraform-example-instance-sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
