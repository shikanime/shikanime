variable "name" {
  type        = string
  description = "Project name"
  default     = "shikanime"
}

variable "cachix" {
  type = object({
    token = string
  })
  sensitive   = true
  description = "Cachix"
}

variable "wakatime" {
  type = object({
    api_key = string
  })
  sensitive   = true
  description = "Wakatime"
}

variable "wakabox" {
  type = object({
    github_gist_id = string
    github_token   = string
  })
  sensitive   = true
  description = "Wakabox"
}

variable "github" {
  type = object({
    token               = string
    app_installation_id = optional(string, "ghain-jGUbBPSwRf4ceNGo")
  })
  description = "GitHub"
}
