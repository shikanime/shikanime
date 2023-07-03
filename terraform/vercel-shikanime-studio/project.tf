resource "vercel_project" "links" {
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
  project_id = vercel_project.links.id
  domain     = "links.shikanime.studio"
}
