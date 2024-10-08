resource "aws_instance" "frontend" {
    count  = 2
    ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type
    subnet_id = element(aws_subnet.public.*.id, count.index)
    key_name = var.key_name
    security_groups = [aws_security_group.frontend_sg.id]
    associate_public_ip_address = true

    user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Frontend Server ${count.index + 1}</h1>" > /var/www/html/index.html
              EOF
  
    tags =  {
        Name = "frontend-${count.index + 1}"
        Tier = "frontend"
    }

}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}


