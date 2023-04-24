resource "tfe_organization" "default" {
  name  = var.name
  email = "engineering@shikanime.studio"
  lifecycle {
    prevent_destroy = true
  }
}
