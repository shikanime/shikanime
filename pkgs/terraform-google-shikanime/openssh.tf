resource "github_user_ssh_key" "default" {
  for_each = var.ssh
  title    = each.value.name
  key      = each.value.public_key
}
