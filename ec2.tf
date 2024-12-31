resource "aws_instance" "sandbox" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.keypair_name
  subnet_id              = aws_subnet.sandbox.id
  vpc_security_group_ids = [aws_security_group.sandbox.id]

  root_block_device {
    volume_type = "gp3"
    volume_size = 8
    tags = {
      Name = "vol-sandbox"
    }
  }

  user_data = file("setup.sh")

  tags = {
    Name = "ec2-sandbox"
  }
}
