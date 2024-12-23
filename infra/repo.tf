data "github_repository" "repo" {
  for_each = var.repositories
  name     = each.value
}

resource "github_branch_protection" "main" {
  for_each = {
    for k, v in var.repositories :
    k => v if !data.github_repository.repo[k].private
  }
  repository_id                   = each.value
  pattern                         = "main"
  require_signed_commits          = true
  required_linear_history         = true
  require_conversation_resolution = true
  required_status_checks {
    strict   = true
    contexts = ["check"]
  }
}

resource "github_branch_protection" "release" {
  for_each = {
    for k, v in var.repositories :
    k => v if !data.github_repository.repo[k].private
  }
  repository_id                   = each.value
  pattern                         = "release-*.*"
  require_signed_commits          = true
  required_linear_history         = true
  require_conversation_resolution = true
  required_status_checks {
    strict   = true
    contexts = ["check"]
  }
}