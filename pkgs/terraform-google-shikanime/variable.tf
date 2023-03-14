variable "name" {
  type        = string
  description = "Release name"
  default     = "shikanime"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "studio"
}

variable "gitlab" {
  type = object({
    owner = string
  })
  description = "GitLab configuration"
  default = {
    owner = "shikalegend"
  }
}

variable "github" {
  type = object({
    owner = string
    reviewers = map(object({
      username = string
    }))
  })
  description = "GitHub configuration"
  default = {
    owner = "shikanime"
    reviewers = {
      shikanime = {
        username = "shikanime"
      }
    }
  }
}

variable "ssh_keys" {
  type = map(object({
    name               = string
    public_key_openssh = string
  }))
  description = "SSH keys"
  default = {
    shikanime = {
      name               = "shikanime"
      public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFpVHzBrvtlzh0eLr6qNttBd5NBZawNJ7PtcAuHJ6pc7 william.phetsinorath@shikanime.studio"
    }
    sfeir = {
      name               = "sfeir"
      public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM2+ZmUgNPNepyMTJnjcu6LoGxEJh5ny8Oxe7bLuFx9q phetsinorath.w@sfeir.com"
    }
    paprec = {
      name               = "paprec"
      public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDsdYurmBmZpWrDV5EJWZlcCPCU3yTyv1uoe7TzQsYAy phetsinorath.w@sfeir.com"
    }
    totalenergies = {
      name               = "totalenergies"
      public_key_openssh = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCz3G+r2ixyTKRWDsfA6jvKsUJlz659feL5OqFuX3ggvyF3Ckv7BOizIhrHoCEB4BLOPdJhwnyjtVyPaldxMtBOBdyc+IuwdDloLDQzUbLT9ux+cVsWekhBblOCJaR7RcQIpWcOnJJc6eJS5yXzOr8kAlqUTref4oPVOxeE+PO+JJbWjg/Y2jUEA4lHPnzfAjXiQe2keXS1qkpvliVoOD/F5V6IZaA6G00vaWGNuCzRSFddxpLtQEKT5oUCHYX9SWdhqbMxRCFVq1X7uMhWBr4cTBQYpCGSuc0hAUcPl2HTjp1Y8ZfSiyD9WE7lrCF65AH/6qxYGbYXF8HqXeLLxDgxRQTMyQuSs6CmL7CIDqIva77+rYffy5ZKYP7g0NMDtZftoCTRAR6lGXVxrpJkzEkEWlFp/tbm5pWrz1g3g5oqFkt3cmWpLVMKlteIxRIW9Y8ezbADN+szSemmI3nJysTFDFD3v8uvXV47/2LMQcneBkJb5fheNNDt4salDXEIS10= al1083054@admin.hubtotal.net"
    }
    lvmh = {
      name               = "lvmh"
      public_key_openssh = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCx7B+ZQhgDn2H5OUHucXgwRtv03T2EUv+f3cGzSYHmpJ7PzAW5GzvXZX/CRYZgbe8KBsVBqaCtvSQwKFWdUk/JyeFiBV9s9d+K8lpxK2vRKLUFRryDtyB6T4v5cic0VjRyLWWFiQ4sKersG2PLsGWOLwBsINBT8jCBgXDb8Cn3blwgA9lJGi7W0JWRUXeGAbiSebYT0wMKOaXWqe+qKCSmS3nG1Tz5iIg8x1rEU9BymVTANIuh231MxYii0p4pdKd/Thj0rRWcptkKSFhXYwY+D8bZn+QamINwOZEoH0GZK4gFL/NesLXuKIf12X+xE/ai9MYzMYiYuKbU1nphQJ3s0wamE0t29sq31Fqq8MzTmc1gRLY/IvE7/axslmnqzgOOyA3DpuIAOqAT1DzByGbmCMbkZLvvyUCcNw0Uf1WkH10m7N4rgXpwC/t5xBzADEPg1RnfLSw/d+5uA1LDsIsPJL/2+rXdJsMvDxJi4hkF3sLjrh2eFsFS7geSRdtATQc= william.phetsinorath-ext@celine.fr"
    }
    galec = {
      name               = "galec"
      public_key_openssh = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1FLWXNonwAVO54PytqJlM+yfG0tyBCuyHtBNl5fPDO83PejM88+aSXza0ZkUtvDnxdnX2gRC4Mvlx5qvelbjJSoEjVkAukMxR9zIr/gQEI4/IV9KK2mM1ClzZC2uh+XIfw1U2ga+ynZYh7Lqbhshc+bA7D3i2roMk2I7sDUH5EBdZ4+mJA/ryVAba24aPwCwF+2FHpquLVDDzDUlOaFfLBJEZtR+Bxm29Z53kdlNRXK/OFFPcF0aQcpFHFq+w5922QqTdt0h2gHPkOREA+uwk3s3z7dREWsFZTCUJ3rSF1yprxqwg2PrnlSzUjKleq+oxrDMkeP/hGP6guJJB37cP9I3xcH0WPDTl5uZlPmuSlZS3vjRobbQrbo8IfrBcY3c/3Vt8zaprpMKPUUSTSJG7unKLy421S0WHnCil212buzCNygx7ClxHwbjKoCpSP0xcWt52WaJaqpdaZvZXpNWtMzBqbgEvdbUgbZd0D2BwlYflIrEESmSAhg0rp6Uo4C8= william.phetsinorath-ext@galec.leclerc"
    }
    renault = {
      name               = "renault"
      public_key_openssh = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+aOoIs2BENu4ZjrPihoQqOMIaUsYhp2q5Eu/A9lTJYtvRnjeIqlFm6YszHZH580Ab5nwiZCKjHOGc2cuPgK8n6nwkGUAYSlcUOqUZSQe1RefcmlTvp9BwVDf5v7ddxX6TjS1OrJOmvtEw4rqpqFrKKP7fYlBP5hRDB215QTBSNXIawnBZydqbAdo0bI/uQufKGPYk7DX1Y9lD5wcJq6wjKVMmhZzYX8PVJs+EQ4ywDw4SISHBA8QeKGWSCncr5f1sg/ynoremDtkWhZWEdCXjPf0iCaVKXcdzJ3KI0U2bOMP94Mpe0LQO0HHwMNt0957HJFW2tCZR5+yfFE32VdplppIugbXzRQcu5w/vf+nBlJ9y438nuXIvWdK3P21o61em1f/+4NLuTwTla8dPosZ3aNX/YK9ZM1C5z3Qq8QHo8JTW3zKG9iWVNfcbLH91HbmWxy5316bvgBV/ssgj7LAHpkGGFbUAf25vZeutZKGZ8miJemvwjjeCYjONdZMdhVM= william.phetsinorath-extern@renault.com"
    }
  }
}

variable "cachix" {
  type = object({
    token = string
  })
  sensitive = true
}

variable "wakatime" {
  type = object({
    api_key = string
  })
  sensitive = true
}

variable "wakabox" {
  type = object({
    github_gist_id = string
    github_token   = string
  })
  sensitive = true
}
