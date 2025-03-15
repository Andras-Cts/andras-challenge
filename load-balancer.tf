# # #### Whole page to uncomment as I build again
resource "google_compute_global_forwarding_rule" "challenge-https-lb" {
  name                  = "global-challengle-https-lb"
  target                = google_compute_target_https_proxy.challenge-lb-target-proxy.self_link
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.website-ip.address
  ip_protocol           = "TCP"
  port_range            = "443"
}


resource "google_compute_target_https_proxy" "challenge-lb-target-proxy" {
  name             = "challenge-target-proxy"
  description      = "Target proxy for challenge https lb"
  url_map          = google_compute_url_map.challenge-url-map.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.website-cert.self_link]
}

resource "google_compute_url_map" "challenge-url-map" {
  name            = "challenge-url-map-target-proxy"
  description     = "Url map for the target proxy"
  default_service = google_compute_backend_bucket.challenge-backend-bucket.self_link

}

resource "google_compute_global_address" "website-ip" {
  provider = google
  name     = "challenge-website-lb-ip"
}


resource "google_compute_managed_ssl_certificate" "website-cert" {
  # provider = google-beta
  name = "challenge-cert"

  managed {
    domains = ["andras-challenge.co.uk", "www.andras-challenge.co.uk", ]
  }
}