terraform {
  required_version = "> 1.9.0"
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 1.251.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.1.0"
    }

    dns = {
      source  = "hashicorp/dns"
      version = "~> 3.4.3"
    }
  }
}

provider "alicloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.alicloud_region
}
