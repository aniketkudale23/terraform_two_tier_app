resource "aws_security_group" "frontend_sg" {
    name = "frontend_sg"
    description = "Allow HTTP and SSH inblound traffic"
    vpc_id = aws_vpc.main.id

    ingress  {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

   ingress  {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    egress  {
       
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
    tags = {
      Name = "frontend_sg"
    }
    
}

resource "aws_security_group" "backend_sg" {
    name = "backend_sg"
    description = "Allow MySQL inbound traffic from fronend tier"
    vpc_id = aws_vpc.main.id


     ingress  {
        description = "MYSQL"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups  = [aws_security_group.frontend_sg.id]
        
    }

    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "backend_sg"
    }
}

    

