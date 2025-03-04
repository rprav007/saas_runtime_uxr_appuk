// ID of the Tenant project where the resources should be deployed to.
variable "tenant_project_id" {
  type = string
}

// Endpoint (IP address) of the cluster.
variable "cluster_endpoint" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}
