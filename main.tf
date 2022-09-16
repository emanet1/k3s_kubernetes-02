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





terraform {
  backend "s3" {
    bucket = "terraform-git1"
    key    = "global/s3/terraform-git1/states-files/tf.tfstate"
    region = "us-east-2"
    dynamodb_table = "terraform-state-locking"
    encrypt = true
  }
}



resource "aws_key_pair" "deployer" {
  key_name   = "EMMANUEL-KEY"
  public_key = tls_private_key.rsa.public_key_openssh
}


  # RSA key of size 4096 bits
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "TF-key" {
    content  = tls_private_key.rsa.private_key_pem
    filename = "tfkey"
}

# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "clarusway-cohort-10-team05"
#   force_destroy = true

#   lifecycle {
#     prevent_destroy = false
#   }

#   versioning {
#     enabled = true
#   }

#   server_side_encryption_configuration {
#     rule{
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }

# #   tags = {
# #     Name        = "My bucket"
# #     Environment = "Dev"
# #   }
# # }

# # resource "aws_s3_bucket_acl" "example" {
# #   bucket = aws_s3_bucket.b.id
# #   acl    = "private"
# }

resource "aws_dynamodb_table" "example" {
  name             = "terraform-state-locking"
  hash_key         = "LockID"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "LockID"
    type = "S"
  }


}












resource "aws_instance" "master" {
  ami        = "ami-0960ab670c8bb45f3"
  key_name = "EMMANUEL-KEY"
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
  key_name = "EMMANUEL-KEY"
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
