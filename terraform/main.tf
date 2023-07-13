provider "aws" {
  region = var.region
}

data "aws_vpc" "this" {
  tags = {
    ops_lookup_vpc = "terraform_managed"
  }
}

# lookup vpc id
resource "aws_route53_zone" "container_registry" {
  name = "registry.tlium.local."

  vpc {
    vpc_id = data.aws_vpc.this.id
  }
}

# get list of supported regions from ps "/common/supported_regions"
# iterate over all regions
resource "aws_route53_record" "region_record" {
  zone_id = aws_route53_zone.container_registry.zone_id
  name    = "container.registry.tlium.local"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "registry-${var.region}.${var.account_name}.tlium.com"
  ]
}
