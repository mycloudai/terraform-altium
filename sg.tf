resource "alicloud_security_group" "app" {
  security_group_name = "${var.sg_name_prefix}-app"
  vpc_id              = alicloud_vpc.altium.id
  resource_group_id   = alicloud_resource_manager_resource_group.altium.id
  tags = {
    Usage = var.tag
  }
  depends_on = [alicloud_vpc.altium]
}

resource "alicloud_security_group_rule" "app_port_80" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.app.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "app_port_22" {
  count             = length(var.allowed_ip_addresses)
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.app.id
  cidr_ip           = var.allowed_ip_addresses[count.index]
}

resource "alicloud_security_group_rule" "https_outbound_example" {
  count             = length(data.dns_a_record_set.example_com.addrs)
  security_group_id = alicloud_security_group.app.id
  type              = "egress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  cidr_ip           = "${data.dns_a_record_set.example_com.addrs[count.index]}/32"
  policy            = "accept"
}

resource "alicloud_security_group_rule" "https_outbound_secureweb" {
  count             = length(data.dns_a_record_set.secureweb_com.addrs)
  security_group_id = alicloud_security_group.app.id
  type              = "egress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  cidr_ip           = "${data.dns_a_record_set.secureweb_com.addrs[count.index]}/32"
  policy            = "accept"
}

resource "alicloud_security_group" "db" {
  security_group_name = "${var.sg_name_prefix}-db"
  vpc_id              = alicloud_vpc.altium.id
  resource_group_id   = alicloud_resource_manager_resource_group.altium.id
  tags = {
    Usage = var.tag
  }
  depends_on = [alicloud_vpc.altium]
}

resource "alicloud_security_group_rule" "db_from_app" {
  type                     = "ingress"
  ip_protocol              = "tcp"
  nic_type                 = "intranet"
  policy                   = "accept"
  port_range               = "3306/3306"
  priority                 = 1
  security_group_id        = alicloud_security_group.db.id
  source_security_group_id = alicloud_security_group.app.id
}

resource "alicloud_security_group_rule" "db_port_3306" {
  count             = length(var.allowed_ip_addresses)
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "3306/3306"
  priority          = 1
  security_group_id = alicloud_security_group.db.id
  cidr_ip           = var.allowed_ip_addresses[count.index]
}

resource "alicloud_security_group_rule" "db_port_22" {
  count             = length(var.allowed_ip_addresses)
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.db.id
  cidr_ip           = var.allowed_ip_addresses[count.index]
}
