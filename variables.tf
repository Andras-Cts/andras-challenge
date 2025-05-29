variable "project_id" {
  description = "The ID of the project"
  type        = string
  default     = "andras-cv-challenge"
}

variable "project_number" {
  description = "The ID of the project"
  type        = string
  default     = "296888346216"
}

variable "region" {
  description = "Region of the main project"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "Zone of the main project "
  type        = string
  default     = "europe-west1-a"
}

variable "machine_type" {
  description = "value of the machine type"
  type        = string
  default     = "e2-small"
}
# TODO: Add this to secret manager, and read it from there!!

variable "cloudflare_zone_id" {
  type    = string
  default = "0d4195bb29481c197381320208bef5d1"
}

# variable "cloudflare_api_token" {}

# variable "placeholder" {
#   type    = string
#   default = "This is just a change to trigger gh actions"
# }

# uncomment this once I have the credentials
# variable "credentials" {
#   description = "credentials value"
#   type = string
#   default = "./keys.json"
# }