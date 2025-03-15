resource "cloudflare_dns_record" "root-domain" {
  zone_id = var.cloudflare_zone_id
  name    = "andras-challenge.co.uk"
  type    = "A"
  content = "34.120.41.65"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "A"
  content = "34.120.41.65"
  ttl     = 1
  proxied = true
}