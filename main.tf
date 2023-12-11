terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}
data "aws_vpc" "private_vpc" {
  default = true

}

resource "aws_instance" "bff_postgress" {
  ami                    = "ami-053b0d53c279acc90" #Ubuntu_server 22.04LTS 
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Grupo_seguridad_bff.id]
  subnet_id              = "subnet-03a1c4d749aec0010"
  #user_data              = file("basic.sh")
  private_ip = "192.168.100.10"
  associate_public_ip_address = true
  key_name = "capstone_2023"
  tags = {
    Name = "servidor bff_ser_linea_postgress"
  }
}
resource "aws_instance" "servilinea_reclutadores" {
  ami                    = "ami-053b0d53c279acc90" #Ubuntu_server 22.04LTS 
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sericios_postulante_reclutador.id]
  subnet_id              = "subnet-03a1c4d749aec0010"
  #user_data              = file("basic.sh")
  private_ip = "192.168.100.20"
  associate_public_ip_address = true
  key_name = "capstone_2023"
  tags = {
    Name = "servidor servicios_linea_postulante"
  }
}


resource "aws_instance" "dialogflow" {
  ami                    = "ami-053b0d53c279acc90" #Ubuntu_server 22.04LTS 
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.dialogflow.id]
  subnet_id              = "subnet-03a1c4d749aec0010"
  user_data              = file("basic.sh")
  private_ip = "192.168.100.30"
  associate_public_ip_address = true
  key_name = "capstone_2023"
  tags = {
    Name = "dialogflow"
  }
}

resource "aws_instance" "only_bff" {
  ami                    = "ami-053b0d53c279acc90" #Ubuntu_server 22.04LTS 
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.only_bff.id]
  subnet_id              = "subnet-03a1c4d749aec0010"
  user_data              = file("basic.sh")
  private_ip = "192.168.100.40"
  associate_public_ip_address = true
  key_name = "capstone_2023"
  tags = {
    Name = "only_bff"
  }
}


resource "aws_security_group" "Grupo_seguridad_bff" {
  name   = "grupo_bff"
  vpc_id = "vpc-0ce148961ee392061"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "acceso a bff "
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "acceso ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "acceso servicios en linea "
    from_port   = 8083
    to_port     = 8083
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "serivicio ssl "
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "nginx port 80 "
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "acceso servicio postgresql "
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}
resource "aws_security_group" "sericios_postulante_reclutador" {
  name        = "servicios_postulante_reclutador"
  description = "Permite acceder al servicio de postulantes y reclutadores"
  vpc_id      = "vpc-0ce148961ee392061"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "acceso a servicio de postulante"
    from_port   = 8081
    to_port     = 8082
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "acceso a servicio ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}

resource "aws_security_group" "dialogflow" {
  name        = "dialogflow"
  description = "Permite el acceso dialogflow"
  vpc_id      = "vpc-0ce148961ee392061"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "acceso a servicio de dialogflow"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    }

    ingress {
      cidr_blocks = ["0.0.0.0/0"]
      description = "acceso a servicio de ssh"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"

    }
  egress {
    cidr_blocks=["0.0.0.0/0"]
    from_port=0
    to_port=0
    protocol="-1"

  }  
}
resource "aws_security_group" "only_bff" {
  name        = "only_bff"
  description = "only_bff"
  vpc_id      = "vpc-0ce148961ee392061"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "acceso servicio bff "
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    }

    ingress {
      cidr_blocks = ["0.0.0.0/0"]
      description = "acceso a servicio de ssh"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"

    }
  egress {
    cidr_blocks=["0.0.0.0/0"]
    from_port=0
    to_port=0
    protocol="-1"

  }
}