provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  #count         = 3
  ami           = "ami-2d39803a"
  instance_type = "t2.micro"

  tags {
    Name = "terraform_example_node"
  }
}
