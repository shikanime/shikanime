data "github_repository" "repo" {
  for_each = var.repositories
  name     = each.value
}

resource "github_repository_ruleset" "default" {
  for_each = {
    for k, v in var.repositories :
    k => v if !data.github_repository.repo[k].private
  }
  name        = "Branch protections"
  repository  = each.value
  target      = "branch"
  enforcement = "active"
  conditions {
    ref_name {
      include = ["refs/heads/main", "refs/heads/release-*.*"]
      exclude = []
    }
  }
  bypass_actors {
    actor_id    = 2 # Maintain
    actor_type  = "RepositoryRole"
    bypass_mode = "always"
  }
  rules {
    required_linear_history = true
    required_signatures     = true
    commit_message_pattern {
      operator = "regex"
      pattern  = "ghstack-source-id: [0-9]+"
    }
  }
}

resource "github_repository_ruleset" "main" {
  for_each = {
    for k, v in var.repositories :
    k => v if !data.github_repository.repo[k].private
  }
  name        = "Main branch protections"
  repository  = each.value
  target      = "branch"
  enforcement = "active"
  conditions {
    ref_name {
      include = ["refs/heads/main"]
      exclude = []
    }
  }
  rules {
    pull_request {
      require_code_owner_review         = true
      required_review_thread_resolution = true
    }
    required_status_checks {
      required_check {
        context        = "check"
        integration_id = 15368 # GitHub Actions
      }
      strict_required_status_checks_policy = true
    }
  }
}

resource "github_repository_ruleset" "release" {
  for_each = {
    for k, v in var.repositories :
    k => v if !data.github_repository.repo[k].private
  }
  name        = "Release branch protections"
  repository  = each.value
  target      = "branch"
  enforcement = "active"
  conditions {
    ref_name {
      include = ["refs/heads/release-*.*"]
      exclude = []
    }
  }
  bypass_actors {
    actor_id    = 2 # Maintain
    actor_type  = "RepositoryRole"
    bypass_mode = "always"
  }
  rules {
    pull_request {
      require_code_owner_review         = true
      required_review_thread_resolution = true
    }
    required_status_checks {
      required_check {
        context        = "check"
        integration_id = 15368 # GitHub Actions
      }
      strict_required_status_checks_policy = true
    }
  }
}