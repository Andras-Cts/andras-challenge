
locals {
  project       = "andras-cv-challenge" # GCP Project ID
  budget_folder = "${local.project}-budget-alert"
  pictures      = fileset("../Pictures", "*") # Grab all files in Pictures folder
  css_files     = fileset("../Css", "*")      # Grab all files in CSS folder
}
