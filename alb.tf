resource "alicloud_ssl_certificates_service_certificate" "altium" {
  certificate_name = var.certificate_name
  cert             = file("${path.module}/ssl/cert.pem")
  key              = file("${path.module}/ssl/key.pem")
}

resource "alicloud_alb_load_balancer" "altium" {
  load_balancer_edition  = "Basic"
  address_type           = "Internet"
  vpc_id                 = alicloud_vpc.altium.id
  address_allocated_mode = "Fixed"
  resource_group_id      = alicloud_resource_manager_resource_group.altium.id
  load_balancer_name     = var.alb_name
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  modification_protection_config {
    status = "NonProtection"
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.altium[0].id
    zone_id    = alicloud_vswitch.altium[0].zone_id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.altium[1].id
    zone_id    = alicloud_vswitch.altium[1].zone_id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.altium[2].id
    zone_id    = alicloud_vswitch.altium[2].zone_id
  }
  tags = {
    Usage = var.tag
  }
  depends_on = [alicloud_ess_scaling_group.altium]
}

resource "alicloud_alb_server_group" "altium" {
  protocol          = "HTTP"
  vpc_id            = alicloud_vpc.altium.id
  server_group_name = var.alb_server_group_name
  scheduler         = "Wlc"
  resource_group_id = alicloud_resource_manager_resource_group.altium.id
  sticky_session_config {
    sticky_session_enabled = false
  }
  health_check_config {
    health_check_connect_port = "80"
    health_check_enabled      = true
    health_check_codes        = ["http_2xx", "http_3xx", "http_4xx"]
    health_check_http_version = "HTTP1.1"
    health_check_interval     = 10
    health_check_method       = "GET"
    health_check_protocol     = "HTTP"
    health_check_path         = var.health_check_path
    health_check_timeout      = 5
    healthy_threshold         = 2
    unhealthy_threshold       = 2
  }
  tags = {
    Usage = var.tag
  }

  depends_on = [alicloud_ess_scaling_group.altium]
}

resource "alicloud_ess_alb_server_group_attachment" "altium" {
  scaling_group_id    = alicloud_ess_scaling_group.altium.id
  alb_server_group_id = alicloud_alb_server_group.altium.id
  port                = 80
  weight              = 100
  depends_on          = [alicloud_ess_scaling_group.altium]
}

resource "alicloud_alb_listener" "altium" {
  load_balancer_id  = alicloud_alb_load_balancer.altium.id
  listener_protocol = "HTTPS"
  listener_port     = 443
  certificates {
    certificate_id = alicloud_ssl_certificates_service_certificate.altium.id
  }
  default_actions {
    type = "ForwardGroup"
    forward_group_config {
      server_group_tuples {
        server_group_id = alicloud_alb_server_group.altium.id
      }
    }
  }
  tags = {
    Usage = var.tag
  }

  depends_on = [
    alicloud_alb_load_balancer.altium,
    alicloud_instance.altium
  ]
}
