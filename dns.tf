# resource "google_dns_managed_zone" "dns-challenge-zone" {
#   name        = "dns-challenge-zone"
#   dns_name    = "andras-challenge.co.uk"
#   description = "DNS zone for my challenge website"
# }
# ### This is a mark to uncomment after destroy
resource "cloudflare_dns_record" "root-domain" {
  zone_id = var.cloudflare_zone_id
  name    = "andras-challenge.co.uk"
  type    = "A"
  content = "34.54.107.19"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "A"
  content = "34.54.107.19"
  ttl     = 1
  proxied = true
}

# already exists in cloudflare, and TF errors out on it
# resource "cloudflare_dns_record" "www" {
#   zone_id = var.cloudflare_zone_id
#   name    = "www"
#   type    = "A"
#   content = "34.49.71.195"
#   ttl     = 1
#   proxied = true
# }