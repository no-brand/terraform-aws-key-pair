# {namespace}-{stage}-{region}-keypair/aws_key_pair/{purpose}/name
resource "aws_ssm_parameter" "keypair_name" {
  name  = format("%s/aws_key_pair/%s/name", local.ssm_parameter_prefix_hyphen, var.purpose)
  type  = "String"
  value = aws_key_pair.this.key_name
}

# {namespace}-{stage}-{region}-keypair-{purpose}.pem
resource "local_file" "pem" {
  filename        = format("%s.pem", aws_key_pair.this.key_name)
  file_permission = "0400"
  content         = tls_private_key.this.private_key_pem
}