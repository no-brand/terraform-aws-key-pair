variable "namespace" {
  description = "Namespace of all resources as identifier."
  type        = string

  validation {
    condition     = can(regex("[[:lower:]]", var.namespace))
    error_message = "Namespace should be lowercase."
  }
}

variable "stage" {
  description = "Stage, such as dev, stg, and prd."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "stg", "prd"], var.stage)
    error_message = "Stage should be one of [dev, stg, prd]."
  }
}

variable "region" {
  description = "AWS region to deploy."
  type        = string

  validation {
    condition     = length(regexall("[a-z]+-[a-z]+-[1-3]", var.region)) > 0
    error_message = "AWS Region format is not valid."
  }
}

variable "tags" {
  description = "Map of tags."
  type        = map(string)
  default     = {}
}

variable "purpose" {
  description = "Purpose of keypair."
  type        = string
  default     = "ec2"
}

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

  region_abbreviation         = local.region_abbreviation_map[var.region]
  module_name                 = "keypair"
  prefix_hyphen               = format("%s-%s-%s-%s", var.namespace, var.stage, local.region_abbreviation, local.module_name)
  prefix_underline            = format("%s_%s_%s-%s", var.namespace, var.stage, local.region_abbreviation, local.module_name)
  ssm_parameter_prefix_hyphen = format("/%s/%s/%s/%s", var.namespace, var.stage, local.region_abbreviation, local.module_name)

  tags = merge({
    TF_MODULE = "KEYPAIR"
  }, var.tags)
}
