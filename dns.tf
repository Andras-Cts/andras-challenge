resource "cloudflare_dns_record" "root-domain" {
  zone_id = var.cloudflare_zone_id
  name    = "andras-challenge.co.uk"
  type    = "A"
  content = "35.190.58.164"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "A"
  content = "35.190.58.164"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "a_records" {
  for_each = toset(local.a_records)
  zone_id  = var.cloudflare_zone_id
  name     = "www"
  type     = "A"
  content  = each.key
  ttl      = 1
  proxied  = false
}

resource "cloudflare_dns_record" "aaaa_records" {
  for_each = toset(local.aaaa_records)
  zone_id  = var.cloudflare_zone_id
  name     = "@"
  type     = "AAAA"
  content  = each.key
  ttl      = 1
  proxied  = false
}