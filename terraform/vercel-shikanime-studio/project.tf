resource "vercel_project" "default" {
  name                       = "links-shikanime-studio"
  framework                  = "nextjs"
  serverless_function_region = "fra1"
  root_directory             = "pkgs/links-shikanime-studio"
  git_repository = {
    type = "github"
    repo = "shikanime/shikanime"
  }
}

resource "vercel_project_domain" "links" {
  project_id = vercel_project.default.id
  domain     = "links.shikanime.studio"
}
