variable "github" {
  type = object({
    ssh_keys = map(object({
      name               = string
      public_key_openssh = string
    }))
    gpg_keys = map(object({
      public_key_armored = string
    }))
  })
  description = "GitHub configuration"
  default = {
    ssh_keys = {
      altashar = {
        name               = "Altashar"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEcC9iJokc4BW6fTW9vz/X/0NhCHQf7WigeMz7ft2bi"
      }
      ishtar = {
        name               = "Ishtar"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHZVBUmDSLiLNRUCeJ1dWNwLWYlpIkxZvUXELWGXUmZ"
      }
    }
    gpg_keys = {
      altashar = {
        public_key_armored = <<-EOF
        -----BEGIN PGP PUBLIC KEY BLOCK-----

        mDMEY3Ii9BYJKwYBBAHaRw8BAQdAVm+ciEoZQodnh3IfMFn4/I/ErCv0SCwCk374
        BcNATku0M1dpbGxpYW0gUGhldHNpbm9yYXRoIDxhbDEwODMwNTRAYWRtaW4uaHVi
        dG90YWwubmV0PoiUBBMWCgA8FiEEvrJWm9gXiXcn9wc+9B+Cdfwu0ukFAmNyIvQC
        GwMFCQHhM4AECwkIBwQVCgkIBRYCAwEAAh4FAheAAAoJEPQfgnX8LtLpaaoBAM4L
        VNnA/omAYlG1OkbLvD7vt7GzJnrWvLOppcYuli/EAQDI16ypThtveOAkR67JfoOv
        hPmhMCJ9s5+NTUl2Uj3mDrg4BGNyIvQSCisGAQQBl1UBBQEBB0DAIIkv30ji54mO
        Wf3V2wK4vxMjLwlD5PjQ+0na2LqSGQMBCAeIfgQYFgoAJhYhBL6yVpvYF4l3J/cH
        PvQfgnX8LtLpBQJjciL0AhsMBQkB4TOAAAoJEPQfgnX8LtLpPtoA/3yOZysAWb1S
        umKn/EB154P/KwaNgpQ3y7qQipyDtlvyAQDAzkSeUIVJARXBMf5M53yC1Ru1qvk9
        Q0LZRV4zbtmgDA==
        =HDY8
        -----END PGP PUBLIC KEY BLOCK-----
        EOF
      }
    }
  }
}
