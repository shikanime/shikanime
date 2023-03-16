data "github_repository" "default" {
  full_name = "${data.github_user.default.username}/${var.github.owner}"
}

resource "github_actions_secret" "cachix_token" {
  repository      = data.github_repository.default.name
  secret_name     = "CACHIX_AUTH_TOKEN"
  encrypted_value = base64encode(var.cachix.token)
}

resource "github_repository_environment" "wakabox" {
  repository  = data.github_repository.default.name
  environment = "${var.name}-${var.environment}-wakabox"
  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}

resource "github_actions_environment_secret" "wakabox_wakatime" {
  repository      = data.github_repository.default.name
  environment     = github_repository_environment.wakabox.environment
  secret_name     = "WAKATIME_API_KEY"
  plaintext_value = var.wakatime.api_key
}
resource "github_actions_environment_variable" "wakabox_gist_id" {
  repository    = data.github_repository.default.name
  environment   = github_repository_environment.wakabox.environment
  variable_name = "WAKABOX_GITHUB_GIST_ID"
  value         = var.wakabox.github_gist_id
}

resource "github_actions_environment_secret" "wakabox_github_token" {
  repository      = data.github_repository.default.name
  environment     = github_repository_environment.wakabox.environment
  secret_name     = "WAKABOX_GITHUB_TOKEN"
  plaintext_value = var.wakabox.github_token
}

data "github_repository" "algorithm" {
  full_name = "${data.github_user.default.username}/algorithm"
}

resource "github_repository_environment" "algorithm" {
  repository  = data.github_repository.algorithm.name
  environment = "${var.name}-${var.environment}"
  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}

resource "github_actions_environment_secret" "algorithm_cachix_token" {
  repository      = data.github_repository.algorithm.name
  environment     = github_repository_environment.algorithm.environment
  secret_name     = "CACHIX_AUTH_TOKEN"
  encrypted_value = base64encode(var.cachix.token)
}
