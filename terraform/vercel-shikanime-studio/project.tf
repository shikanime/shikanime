resource "vercel_project" "default" {
  name                       = "shikanime-studio"
  framework                  = "nextjs"
  serverless_function_region = "fra1"
  root_directory             = "pkgs/shikanime-studio"
  git_repository = {
    type = "github"
    repo = "shikanime/shikanime"
  }
}

resource "vercel_project_domain" "canary" {
  project_id = vercel_project.default.id
  domain     = "canary.shikanime.studio"
  git_branch = "feat/add-page"
}
