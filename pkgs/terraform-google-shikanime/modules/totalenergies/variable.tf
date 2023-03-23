variable "github" {
  type = object({
    owner = string
    ssh_keys = map(object({
      name               = string
      public_key_openssh = string
    }))
  })
  description = "GitHub configuration"
  default = {
    owner = "shikanime"
    ssh_keys = {
      altashar = {
        name               = "Altashar"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEcC9iJokc4BW6fTW9vz/X/0NhCHQf7WigeMz7ft2bi"
      }
    }
  }
}
