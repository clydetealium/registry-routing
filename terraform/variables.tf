variable "account_name" {
  type = string
  default = "pem"
}

variable "region" {
  type = string
  default = "us-west-2"
}

# Standard variables filled in using matching TF_VAR_* environment variables in the shared lib
# variable "account_id" {
#   type        = string
#   description = "The numeric AWS account id to deploy in, this is a string to handle some accounts starting with zero."

#   validation {
#     condition     = length(regex("^(?P<id>[\\d]{12})$", var.account_id).id) == 12
#     error_message = "The account_id value must be a valid 12 digit AWS account ID."
#   }
# }

# variable "account_name" {
#   type        = string
#   description = "The short AWS account name to deploy in."
# }

# variable "component" {
#   type        = string
#   description = "The compoent name this is for."
# }

# variable "environment" {
#   type        = string
#   description = "The environment this is running in."
# }

# variable "environment_type" {
#   type        = string
#   description = "The environment type this is running in, only one of [prod, qa, dev]."

#   validation {
#     condition     = contains(["dev", "qa", "prod"], var.environment_type)
#     error_message = "The environment_type must only be one of [dev, qa, prod]."
#   }
# }

# variable "platform_name" {
#   type        = string
#   description = "The platform name to deploy in."
# }

# variable "region" {
#   type        = string
#   description = "The region to deploy in."
# }

# variable "jenkins_region" {
#   type        = string
#   description = "The local region where Jenkins is running."
# }