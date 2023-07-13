variable "base_region" {
  type = string
  default = "us-east-1"
}

variable "account_alias" {
  type = string
  default = "pem"
}

variable "regions" {
  type = list
  default = [
    "us-east-1",
    "us-west-2",
  ]
}