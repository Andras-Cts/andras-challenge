
locals {
  project       = "andras-cv-challenge" # GCP Project ID
  budget_folder = "${local.project}-budget-alert"
  pictures      = fileset("${path.module}/webpage/Pictures", "*") # Grab all files in Pictures folder
  css_files     = fileset("${path.module}/webpage/CSS", "*")      # Grab all files in CSS folder
}
