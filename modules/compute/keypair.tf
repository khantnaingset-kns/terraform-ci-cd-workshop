
resource "aws_key_pair" "deployer" {
  key_name   = var.ec2_key_pair_name
  public_key = var.ec2_key_pair_public_key
}
