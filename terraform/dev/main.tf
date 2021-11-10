#------------------------------------------------------------------------------
# The best practice is to use remote state file and encrypt it since your
# state files may contains sensitive data (secrets).
#------------------------------------------------------------------------------
# terraform {
#       backend "s3" {
#             bucket = "remote-terraform-state-dev"
#             encrypt = true
#             key = "terraform.tfstate"
#             region = "us-east-1"
#       }
# }
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
  }
}


provider "docker" { }

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}


resource "docker_container" "nginx" {
  name = "nginx"
  image = docker_image.nginx.latest
  ports {
    internal = 80
    external = 9001
  }
}


resource "docker_image" "vault" {
  name         = "vault:latest"
  keep_locally = false
}

data "docker_registry_image" "train-builder" {
  name = "ghcr.io/pht-medic/train-builder:latest"
}

resource "docker_image" "train-builder" {
  name          = data.docker_registry_image.train-builder.name
  pull_triggers = [data.docker_registry_image.train-builder.sha256_digest]
}

resource "docker_container" "train-builder" {
  name = "train-builder"
  image = docker_image.train-builder.latest
}


resource "docker_container" "vault" {
  image = docker_image.vault.latest
  name  = "vault"
  ports {
    internal = 3400
    external = 9002
  }
  volumes {
    host_path = "/mnt/c/Users/micha/tbi/pht/terraform-deploy/dev/vault/"
    container_path = "/vault/"
  }
  env = []
}


## Use Vault provider
#provider "vault" {
#  # It is strongly recommended to configure this provider through the
#  # environment variables:
#  #    - VAULT_ADDR
#  #    - VAULT_TOKEN
#  #    - VAULT_CACERT
#  #    - VAULT_CAPATH
#  #    - etc.
#}
