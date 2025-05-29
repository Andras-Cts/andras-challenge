
locals {
  project       = "andras-cv-challenge" # GCP Project ID
  budget_folder = "${local.project}-budget-alert"
  pictures      = fileset("${path.module}/webpage/Pictures", "*") # Grab all files in Pictures folder
  css_files     = fileset("${path.module}/webpage/CSS", "*")      # Grab all files in CSS folder
  a_records     = ["216.239.32.21", "216.239.34.21", "216.239.36.21", "216.239.38.21"]
  aaaa_records  = ["2001:4860:4802:32::15", "2001:4860:4802:34::15", "2001:4860:4802:36::15", "2001:4860:4802:38::15", ]
}