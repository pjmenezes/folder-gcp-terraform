#terraform {
#  required_providers {
#    google = {
#      source  = "hashicorp/google"
#      version = "3.73.0"
#    }
#  }

#  required_version = ">= 0.15.0"
#}

provider "google" {
  project = "animated-alloy-369522"
  region  = "us-central1"
  zone    = "us-central1-c"
  credentials = "${file("serviceaccount.yaml")}"
}

resource "google_folder" "Financeiro" {
    display_name = "Financeiro"
    parent = "organizations/567788326729"
}

resource "google_folder" "SalesForce" {
    display_name = "SalesForce"
    parent = google_folder.Financeiro.name
}

resource "google_folder" "Desenvolvimento" {
  display_name = "Desenvolvimento"
  parent = google_folder.SalesForce.name
}

resource "google_folder" "Producao" {
    display_name = "Produção"
    parent = google_folder.SalesForce.name
}

resource "google_project" "Paperless-Project" {
    name = "Paperless-Project" 
    project_id = "animated-alloy-369522" 
    folder_id = google_folder.Desenvolvimento.name
    auto_create_network = false
    billing_account = "011D89-85258E-113151	"
}



#module "project_services" {
#  source  = "terraform-google-modules/project-factory/google//modules/project_services"
#  version = "3.3.0"

#  project_id = "valiant-sandbox-367120"

#  activate_apis = [
#    "compute.googleapis.com",
#    "oslogin.googleapis.com"
#  ]

#  disable_services_on_destroy = false
#  disable_dependent_services  = false
#}
