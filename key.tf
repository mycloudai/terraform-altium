resource "tls_private_key" "altium" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "alicloud_ecs_key_pair" "altium" {
  key_pair_name     = var.key_pair_name
  public_key        = tls_private_key.altium.public_key_openssh
  resource_group_id = alicloud_resource_manager_resource_group.altium.id
  tags = {
    Usage = var.tag
  }
  depends_on = [alicloud_resource_manager_resource_group.altium]
}
