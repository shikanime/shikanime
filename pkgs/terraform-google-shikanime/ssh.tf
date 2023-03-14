resource "github_user_ssh_key" "default" {
  for_each = var.ssh_keys
  title    = title(each.value.name)
  key      = each.value.public_key_openssh
}

resource "time_rotating" "gitlab_ssh_key_expiration" {
  rotation_months = 3
}

resource "gitlab_user_sshkey" "default" {
  for_each   = var.ssh_keys
  user_id    = data.gitlab_user.current.id
  title      = title(var.name)
  key        = each.value.public_key_openssh
  expires_at = formatdate("YYYY-MM-DD'T'HH:mm:ssZ", time_rotating.gitlab_ssh_key_expiration.rotation_rfc3339)
}
