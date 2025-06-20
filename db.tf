resource "alicloud_instance" "altium" {
  availability_zone          = data.alicloud_zones.available.zones[1].id
  instance_name              = var.db_name
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.instance_type
  security_groups            = [alicloud_security_group.db.id]
  key_name                   = alicloud_ecs_key_pair.altium.key_pair_name
  internet_max_bandwidth_out = var.internet_bandwidth
  internet_charge_type       = "PayByTraffic"
  instance_charge_type       = "PostPaid"
  spot_price_limit           = var.spot_price_limit
  spot_strategy              = "SpotWithPriceLimit"
  system_disk_category       = "cloud_efficiency"
  system_disk_name           = var.db_name
  system_disk_size           = 40
  vswitch_id                 = alicloud_vswitch.altium[1].id

  user_data = base64encode(templatefile("${path.module}/user-data-db.sh", {
    db_password = var.db_password
  }))

  tags = {
    Usage = var.tag
  }

  depends_on = [alicloud_ecs_key_pair.altium]
}
