data "alicloud_zones" "available" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

data "alicloud_images" "default" {
  most_recent  = true
  owners       = "system"
  architecture = "x86_64"
  name_regex   = "^ubuntu_24"
}

data "dns_a_record_set" "example_com" {
  host = "example.com"
}

data "dns_a_record_set" "secureweb_com" {
  host = "secureweb.com"
}
