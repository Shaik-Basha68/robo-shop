resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = local.az
  vpc_security_group_ids = [local.sg_id]

  tags = merge(
    var.instance_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-bastion"
    }
  )
}

resource "aws_instance" "app2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = local.mongo_subnet_id
  vpc_security_group_ids = [local.mongo_sg_id]

  tags = merge(
    var.instance_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-mongo"
    }
  )
}

resource "terraform_data" "mongo" {
  input = {
    instance_id = aws_instance.app2.id
    private_ip  = aws_instance.app2.private_ip
  }

  provisioner "local-exec" {
    when    = "create"
    command = "echo ${self.input.private_ip} >> mongo_private_ip.txt && echo ${self.input.instance_id} >> mongo_instance_id.txt"
  }
  

  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = "Basha@6861"
    #private_key = file(var.private_key_path)
    host        = aws_instance.app2.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo Hello from Bastion instance with ID ${self.input.instance_id} and private IP ${self.input.private_ip}"
    ]
  }
}