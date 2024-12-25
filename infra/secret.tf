locals {
  wakabox_data = jsondecode(base64decode(data.scaleway_secret_version.wakabox.data))
  nix_data     = jsondecode(base64decode(data.scaleway_secret_version.nix.data))

  operator_openssh_private_key = base64decode(data.scaleway_secret_version.operator.data)
}

data "scaleway_secret_version" "wakabox" {
  secret_id = var.secrets.wakabox
  revision  = "latest"
}

data "scaleway_secret_version" "nix" {
  secret_id = var.secrets.nix
  revision  = "latest"
}

data "scaleway_secret_version" "operator" {
  secret_id = var.secrets.operator
  revision  = "latest"
}
