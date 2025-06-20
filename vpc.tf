resource "alicloud_resource_manager_resource_group" "altium" {
  resource_group_name = var.resource_group_name
  display_name        = var.resource_group_name
  tags = {
    Usage = var.tag
  }
}

resource "alicloud_vpc" "altium" {
  vpc_name          = var.vpc_name
  cidr_block        = var.vpc_cidr
  resource_group_id = alicloud_resource_manager_resource_group.altium.id
  tags = {
    Usage = var.tag
  }
  depends_on = [alicloud_resource_manager_resource_group.altium]
}

resource "alicloud_vswitch" "altium" {
  count        = 3
  vpc_id       = alicloud_vpc.altium.id
  cidr_block   = cidrsubnet(var.vpc_cidr, 8, count.index)
  zone_id      = data.alicloud_zones.available.zones[count.index].id
  vswitch_name = "${var.vswitch_name_prefix}-${count.index + 1}"
  tags = {
    Usage = var.tag
  }
  depends_on = [alicloud_vpc.altium]
}
