terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.59.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "master" {
  ami        = "ami-0960ab670c8bb45f3"
  key_name = "mydev1"
  vpc_security_group_ids = [aws_security_group.k3s_server.id]
  instance_type          = "t3a.medium"
  user_data = base64encode(templatefile("${path.module}/server-userdata.tmpl", {
    token = random_password.k3s_cluster_secret.result
  })) # token = shared secret used to join a server or agent to a cluster
  
  

  tags = {
    Name = "k3sServerhacksoul"
  }
}



resource "aws_instance" "worker" {
  ami = "ami-0960ab670c8bb45f3" 
  key_name = "mydev1"
  vpc_security_group_ids = [aws_security_group.k3s_agent.id]
  instance_type = "t3a.medium" 
  user_data = base64encode(templatefile("${path.module}/agent-userdata.tmpl", {
    host  = aws_instance.master.private_ip,
    token = random_password.k3s_cluster_secret.result
  }))
  depends_on = [ aws_instance.master ]
  tags = {
    Name = "k3sWorkerhacksoul"
  }
}
