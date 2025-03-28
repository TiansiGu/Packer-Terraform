data "aws_ami" "ec2_amazon_linux_image" {
  most_recent = true
  owners      = ["self"] //check your own AMIs
  filter {
    name = "name"
    values = ["amazon-linux-2023-with-docker*"] //custom Amazon Linux AMI with docker and ssh key set up
  }
}

data "aws_ami" "ec2_ubuntu_image" {
  most_recent = true
  owners      = ["self"] //check your own AMIs
  filter {
    name = "name"
    values = ["ubuntu-with-docker*"] //custom Ubuntu AMI with docker and ssh key set up
  }
}


resource "aws_instance" "ec2-amazon-linux" {
  count         = var.amazon_linux_ec2_count
  ami           = data.aws_ami.ec2_amazon_linux_image.id
  instance_type = "t2.micro"
  subnet_id = module.vpc.private_subnets[0] //the first private subnet id in the list
  vpc_security_group_ids = [aws_security_group.private-ssh.id]

  tags = merge(
    var.resource_tags,
    { Name = "amazon-linux-${format("%02d", count.index + 1)}" }, //amazon-linux-01, amazon-linux-02, ...
    { OS   = "amazon" }
  )
}

resource "aws_instance" "ec2-ubuntu" {
  count         = var.ubuntu_ec2_count
  ami           = data.aws_ami.ec2_ubuntu_image.id
  instance_type = "t2.micro"
  subnet_id = module.vpc.private_subnets[1] //the second private subnet id in the list
  vpc_security_group_ids = [aws_security_group.private-ssh.id]

  tags = merge(
    var.resource_tags,
    { Name = "ubuntu-${format("%02d", count.index + 1)}" }, //ubuntu-01, ubuntu-02, ...
    { OS   = "ubuntu" }
  )
}