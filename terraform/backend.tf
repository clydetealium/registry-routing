terraform {
  backend "s3" {
    bucket               = "tealium-terraform"
    key                  = "registry-routing/terraform.tfstate"
    region               = "us-east-1"
    workspace_key_prefix = "registry-routing"
    kms_key_id           = "arn:aws:kms:us-east-1:586288223691:key/ac0ecce3-19cb-4516-bdae-23465269acd5"
    encrypt              = true
    dynamodb_table       = "terraform_locks"
    role_arn             = "arn:aws:iam::586288223691:role/jenkins-cross-account-access"
  }

  required_version = "= 1.4.2"
}