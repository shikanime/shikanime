resource "tfe_organization" "default" {
  name  = var.name
  email = var.email
  lifecycle {
    prevent_destroy = true
  }
}
