resource "github_repository" "default" {
  name          = var.name
  description   = "あらあらー\u3000( ⓛ ω ⓛ *)"
  has_downloads = true
  has_issues    = true
  lifecycle {
    prevent_destroy = true
  }
}
