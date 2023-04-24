variable "name" {
  type        = string
  description = "Project name"
  default     = "shikanime"
}

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
      ishtar = {
        name               = "Ishtar"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPW5kSIFStkESjXOavgJg75Wfxnsml7+ZT0grMnYNzwC"
      }
      ishtar_sfeir = {
        name               = "Ishtar Sfeir"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIJP9KGbfSjJ4RxrapCoWeIYASQYjwS7Cd+jha3POFyy"
      }
      altashar = {
        name               = "Altashar"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAB8e13bjswnhfuYYpztBESPf/gkbkdGE46kC++tNOCX"
      }
      altashar_sfeir = {
        name               = "Altashar Sfeir"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKBei/1ZMgt7aiixXdHaHp5T0kmRfzNDD9oO1DkyxY/H"
      }
    }
    gpg_keys = {
      altashar = {
        public_key_armored = <<-EOF
        -----BEGIN PGP PUBLIC KEY BLOCK-----

        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
        r1db0JpB7lD/AcPwQFVToNe09Y5cVid4rA==
        =Qitg
        -----END PGP PUBLIC KEY BLOCK-----
        EOF
      }
    }
    altashar_sfeir = {
      public_key_armored = <<-EOF
      -----BEGIN PGP PUBLIC KEY BLOCK-----

      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
      HEBGjvzZg19arSM3yel/DiwrlP8b
      =JC4G
      -----END PGP PUBLIC KEY BLOCK-----
      EOF
    }
  }
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
    github_gist_id = optional(string, "18a5a8350c7bfe760adb6c37b6bbe5a9")
    github_token   = string
  })
  sensitive   = true
  description = "Wakabox"
}
