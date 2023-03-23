resource "github_user_gpg_key" "example" {
  for_each           = var.github.gpg_keys
  armored_public_key = each.value.public_key_armored
}
