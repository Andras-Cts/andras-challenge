variable "project_id" {
  description = "The ID of the project"
  type        = string
  default     = "cts-sbx-d03-eloquent-carson"
}

variable "project_number" {
  description = "The ID of the project"
  type        = string
  default     = "1078797412348"
}

variable "region" {
  description = "Region of the main project"
  type        = string
  default     = "europe-west2"
}

variable "zone" {
  description = "Zone of the main project "
  type        = string
  default     = "europe-west2-a"
}

variable "machine_type" {
  description = "value of the machine type"
  type        = string
  default     = "e2-small"
}
# TODO: Add this to secret manager, and read it from there!!

variable "cloudflare_zone_id" {
  type    = string
  default = "f71d3c051957241fded675f6f278201b"
}

variable "placeholder" {
  type    = string
  default = "This is just a change to trigger gh actions"
}

# uncomment this once I have the credentials
# variable "credentials" {
#   description = "credentials value"
#   type = string
#   default = "./keys.json"
# }