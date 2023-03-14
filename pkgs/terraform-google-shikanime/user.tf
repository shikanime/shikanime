data "github_user" "reviewers" {
  for_each = var.github.reviewers
  username = each.value.username
}

data "github_user" "current" {
  username = var.github.owner
}

data "gitlab_user" "current" {
  username = var.gitlab.owner
}
