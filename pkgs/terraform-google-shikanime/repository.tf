data "github_user" "reviewers" {
  for_each = var.github.reviewers
  username = each.value.username
}

data "github_repository" "default" {
  full_name = "${var.github.organization}/${var.github.organization}"
}

resource "github_repository_environment" "default" {
  repository  = data.github_repository.default.name
  environment = "${var.name}-${var.environment}"
  reviewers {
    users = [
      for user in data.github_user.reviewers : user.id
    ]
  }
  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}

resource "github_actions_environment_secret" "rclone_config" {
  repository  = data.github_repository.default.name
  environment = github_repository_environment.default.environment
  secret_name = "RCLONE_CONFIG"
  encrypted_value = base64encode(
    <<-EOF
    [shikanime]
    type = drive
    client_id = ${var.rclone.client_id}
    client_secret = ${var.rclone.client_secret}
    scope = drive.appfolder
    service_account_file = ~GOOGLE_APPLICATION_CREDENTIALS
    EOF
  )
}

resource "github_actions_environment_secret" "wakatime" {
  repository      = data.github_repository.default.name
  environment     = github_repository_environment.default.environment
  secret_name     = "WAKATIME_API_KEY"
  encrypted_value = base64encode(var.wakatime.api_key)
}

resource "github_actions_environment_secret" "cachix_token" {
  repository      = data.github_repository.default.name
  environment     = github_repository_environment.default.environment
  secret_name     = "CACHIX_AUTH_TOKEN"
  encrypted_value = base64encode(var.cachix.token)
}

resource "github_actions_environment_secret" "wakabox_gist_id" {
  repository      = data.github_repository.default.name
  environment     = github_repository_environment.default.environment
  secret_name     = "WAKABOX_GITHUB_GIST_ID"
  encrypted_value = base64encode(var.wakabox.github_gist_id)
}

resource "github_actions_environment_secret" "wakabox_github_token" {
  repository      = data.github_repository.default.name
  environment     = github_repository_environment.default.environment
  secret_name     = "WAKABOX_GITHUB_TOKEN"
  encrypted_value = base64encode(var.wakabox.github_token)
}

data "github_repository" "algorithm" {
  full_name = "${var.github.organization}/algorithm"
}

resource "github_repository_environment" "algorithm" {
  repository  = data.github_repository.algorithm.name
  environment = "${var.name}-${var.environment}"
  reviewers {
    users = [
      for user in data.github_user.reviewers : user.id
    ]
  }
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
