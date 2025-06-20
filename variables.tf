variable "access_key" {
  type    = string
  default = "access_key"
}

variable "secret_key" {
  type    = string
  default = "secret_key"
}

variable "alicloud_region" {
  type    = string
  default = "cn-hongkong"
}

variable "tag" {
  type    = string
  default = "terraform"
}

variable "resource_group_name" {
  type    = string
  default = "altium"
}

variable "vpc_name" {
  type    = string
  default = "vpc-altium"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vswitch_name_prefix" {
  type    = string
  default = "vswitch-altium"
}

variable "eip_name_prefix" {
  type    = string
  default = "eip-altium"
}

variable "sg_name_prefix" {
  type    = string
  default = "sg-altium"
}

variable "allowed_ip_addresses" {
  type = list(string)
  default = [
    "10.0.0.0/8",
    "15.0.0.0/8",
    "16.0.0.0/8"
  ]
}

variable "key_pair_name" {
  type    = string
  default = "keypair-altium"
}

variable "db_name" {
  type    = string
  default = "db-altium"
}

variable "db_password" {
  type    = string
  default = "password123"
}

variable "instance_type" {
  type    = string
  default = "ecs.t5-lc1m2.small"
}

variable "internet_bandwidth" {
  type    = number
  default = 1
}

variable "spot_price_limit" {
  type    = string
  default = "0.1"
}

variable "launch_template_name" {
  type    = string
  default = "template-altium"
}

variable "scaling_group_name" {
  type    = string
  default = "asg-altium"
}

variable "min_instances" {
  type    = number
  default = 1
}

variable "max_instances" {
  type    = number
  default = 5
}

variable "memory_high_threshold" {
  type    = number
  default = 80
}

variable "memory_low_threshold" {
  type    = number
  default = 20
}

variable "cpu_high_threshold" {
  type    = number
  default = 80
}

variable "cpu_low_threshold" {
  type    = number
  default = 10
}

variable "pkg_repository" {
  type    = string
  default = "example.com"
}

variable "pkg_name" {
  type    = string
  default = "nginx"
}


variable "certificate_name" {
  type    = string
  default = "cert-altium"
}


variable "alb_name" {
  type    = string
  default = "alb-altium"
}

variable "alb_server_group_name" {
  type    = string
  default = "albsevergroup-altium"
}

variable "health_check_path" {
  type    = string
  default = "/"
}
