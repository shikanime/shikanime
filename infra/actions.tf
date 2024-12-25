resource "github_actions_secret" "wakabox_github_token" {
  repository      = var.repositories.shikanime
  secret_name     = "WAKABOX_GITHUB_TOKEN"
  plaintext_value = local.wakabox_data["githubToken"]
}

resource "github_actions_secret" "wakatime_api_key" {
  for_each        = var.repositories
  repository      = each.value
  secret_name     = "WAKATIME_API_KEY"
  plaintext_value = local.wakabox_data["wakatimeApiKey"]
}

resource "github_actions_secret" "cachix_auth_token" {
  for_each        = var.repositories
  repository      = each.value
  secret_name     = "CACHIX_AUTH_TOKEN"
  plaintext_value = local.nix_data["cachixAuthToken"]
}

resource "github_actions_secret" "gpg_passphrase" {
  for_each        = var.repositories
  repository      = each.value
  secret_name     = "GPG_PASSPHRASE"
  plaintext_value = local.nix_data["gpgPassphrase"]
}

resource "github_actions_secret" "gpg_private_key" {
  for_each        = var.repositories
  repository      = each.value
  secret_name     = "GPG_PRIVATE_KEY"
  plaintext_value = local.nix_data["gpgPrivateKey"]
}

resource "github_actions_secret" "nix_github_token" {
  for_each        = var.repositories
  repository      = each.value
  secret_name     = "NIX_GITHUB_TOKEN"
  plaintext_value = local.nix_data["githubToken"]
}
