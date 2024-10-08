resource "aws_instance" "backend" {
    ami = data.aws_ami.mysql.id
    instance_type = var.instance_type
    subnet_id = element(aws_subnet.private.*.id,0)
    key_name = var.key_name
    security_groups = [aws_security_group.backend_sg.id]
    associate_public_ip_address = false
    


    user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y mysql-server
              systemctl start mysqld
              systemctl enable mysqld
              
              # Secure MySQL installation
              mysql -e "UPDATE mysql.user SET Password = PASSWORD('${var.db_password}') WHERE User = 'root';"
              mysql -e "DELETE FROM mysql.user WHERE User='';"
              mysql -e "DROP DATABASE test;"
              mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
              mysql -e "FLUSH PRIVILEGES;"
              
              EOF

  tags = {
    Name = "backend-db"
    Tier = "backend"
  }

}

data "aws_ami" "mysql" {
    most_recent = true
    filter {
      name = "name"
      values  = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }

    filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
  