provider "aws" {
  region = var.base_region
}

resource "aws_route53_zone" "container_registry" {
  name = "container.com."
}

# iterate over all regions
resource "aws_route53_record" "region_record" {
  for_each = { for region in var.regions : region => region }
  zone_id = aws_route53_zone.container_registry.zone_id
  name    = "reg.container.com"
  type    = "CNAME"
  ttl     = "300"

  set_identifier = "${each.key}-${var.account_alias}-local-reg"

  latency_routing_policy {
    region = each.value
  }

  records = [
    "registry-${each.key}.${var.account_alias}.tlium.com"
  ]
}
