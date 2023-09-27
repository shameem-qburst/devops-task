resource "aws_instance" "intro" {
  ami                    = var.AMIS[var.REGION]
  vpc_security_group_ids = ["sg-07bf09b10b0aeb44b"]
  key_name               = "ras_key_shameem_aws"
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  tags = {
    name = "intro"
  }
}
