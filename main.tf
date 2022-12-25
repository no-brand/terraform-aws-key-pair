resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# {namespace}-{stage}-{region}-keypair-{purpose}
resource "aws_key_pair" "this" {
  key_name   = format("%s-%s", local.prefix_hyphen, var.purpose)
  public_key = tls_private_key.this.public_key_openssh

  tags = merge({
    Name              = format("%s-%s", local.prefix_hyphen, var.purpose)
    RESOURCE_CATEGORY = "SECURITY"
  }, local.tags)
}
