data "github_user" "reviewers" {
  for_each = var.github.reviewers
  username = each.value.username
}

data "github_user" "default" {
  username = var.github.owner
}

data "gitlab_user" "default" {
  username = var.gitlab.owner
}
