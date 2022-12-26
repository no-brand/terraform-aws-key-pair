locals {
  region_abbreviation_map = {
    "us-east-1"      = "usea1"
    "us-east-2"      = "usea2"
    "us-west-1"      = "uswe1"
    "us-west-2"      = "uswe2"
    "us-gov-west-1"  = "ugwe1"
    "ca-central-1"   = "cace1"
    "eu-west-1"      = "euwe1"
    "eu-west-2"      = "euwe2"
    "eu-central-1"   = "euce1"
    "ap-southeast-1" = "apse1"
    "ap-southeast-2" = "apse2"
    "ap-south-1"     = "apso1"
    "ap-northeast-1" = "apne1"
    "ap-northeast-2" = "apne2"
    "ap-northeast-3" = "apne3"
    "sa-east-1"      = "saea1"
    "cn-north-1"     = "cnno1"
  }

  namespace           = "namespace"
  stage               = "dev"
  region              = "ap-northeast-2"
  region_abbreviation = local.region_abbreviation_map[local.region]

  tags = {
    PROJECT     = "NAMESPACE"
    SUB_PROJECT = "NAMESPACE"
    CATEGORY    = "OPERATION"
  }
}

provider "aws" {
  region = local.region
}

module "keypair" {
  source    = "../"
  namespace = local.namespace
  stage     = local.stage
  region    = local.region
  tags      = local.tags
  purpose   = "bastion"
}
