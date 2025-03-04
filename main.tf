terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0" # Or your preferred version
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0" # Or your preferred version
    }
  }
}

provider "google" {
  project = var.tenant_project_id
}

# Add this missing data source
data "google_client_config" "default" {}

# Configure the Kubernetes Provider
provider "kubernetes" {
  host = "https://${var.cluster_endpoint}"
  # You might need to configure authentication
  # depending on your cluster setup.
  # Refer to the Kubernetes provider documentation for details.
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

resource "kubernetes_manifest" "app_deployment" {
  provider = kubernetes
  manifest = yamldecode(templatefile("${path.module}/app.yaml.tmpl", {}))
}
