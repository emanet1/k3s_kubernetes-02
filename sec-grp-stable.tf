resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default-VPC"
  }
}

resource "aws_security_group" "k3s_server" {
  name = "k3s-server-orl"
  #description = "Allow TLS inbound traffic".
  vpc_id = aws_default_vpc.default.id

  ingress = [
    {
      description       = "for ssh"
      from_port         = 22
      to_port           = 22
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = ["::/0"]
      prefix_list_ids   = null
      security_groups   = null
      self              = null
      #security_group_id = aws_security_group.k3s_server.id
    },
    {
      description       = "for http"
      from_port         = 80
      to_port           = 80
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = ["::/0"]
      prefix_list_ids   = null
      security_groups   = null
      self              = null
      #security_group_id = aws_security_group.k3s_server.id
    },
    {
      description       = "for http."
      from_port         = 8080
      to_port           = 8080
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = ["::/0"]
      prefix_list_ids   = null
      security_groups   = null
      self              = null
      #security_group_id = aws_security_group.k3s_server.id
    },
    {
      description       = "for http."
      from_port         = 8085
      to_port           = 8085
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = ["::/0"]
      prefix_list_ids   = null
      security_groups   = null
      self              = null
      #security_group_id = aws_security_group.k3s_server.id
    },

    {
      description       = "for https"
      from_port         = 443
      to_port           = 443
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = ["::/0"]
      prefix_list_ids   = null
      security_groups   = null
      self              = null
      #security_group_id = aws_security_group.k3s_server.id
    },
    {
      description       = "for k8s"
      from_port         = 6443
      to_port           = 6443
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = ["::/0"]
      prefix_list_ids   = null
      security_groups   = null
      self              = null
      #security_group_id = aws_security_group.k3s_server.id
    },
   
  ]
  egress = [
    {
      description      = "allow all"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    Name = "k3s-server-sg2"
  }
}

resource "aws_security_group" "k3s_agent" {
  name = "k3s-agent-orl"
  #description = "Allow TLS inbound traffic"
  vpc_id = aws_default_vpc.default.id

  ingress = [
    {
      description       = "for ssh"
      from_port         = 22
      to_port           = 22
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = ["::/0"]
      prefix_list_ids   = null
      security_groups   = null
      self              = null
      #security_group_id = aws_security_group.k3s_server.id
    },
    {
      description       = "for http"
      from_port         = 80
      to_port           = 80
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = ["::/0"]
      prefix_list_ids   = null
      security_groups   = null
      self              = null
      #security_group_id = aws_security_group.k3s_server.id
    },
    {
      description       = "for http."
      from_port         = 8080
      to_port           = 8080
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = ["::/0"]
      prefix_list_ids   = null
      security_groups   = null
      self              = null
      #security_group_id = aws_security_group.k3s_server.id
    },
    {
      description       = "for http."
      from_port         = 8085
      to_port           = 8085
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = ["::/0"]
      prefix_list_ids   = null
      security_groups   = null
      self              = null
      #security_group_id = aws_security_group.k3s_server.id
    },
    {
      description       = "for k8s"
      from_port         = 6443
      to_port           = 6443
      protocol          = "tcp"
      cidr_blocks       = ["0.0.0.0/0"]
      ipv6_cidr_blocks  = ["::/0"]
      prefix_list_ids   = null
      security_groups   = null
      self              = null
      #security_group_id = aws_security_group.k3s_server.id
    },

  ]

  egress = [
    {
      description      = null
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null

    }
  ]

  tags = {
    Name = "k3s-agent-sg2"
  }
}
