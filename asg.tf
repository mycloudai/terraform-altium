resource "alicloud_ecs_launch_template" "altium" {
  launch_template_name       = var.launch_template_name
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.instance_type
  security_group_ids         = [alicloud_security_group.app.id]
  key_pair_name              = alicloud_ecs_key_pair.altium.key_pair_name
  internet_max_bandwidth_out = var.internet_bandwidth
  internet_charge_type       = "PayByTraffic"
  instance_charge_type       = "PostPaid"
  spot_price_limit           = var.spot_price_limit
  spot_strategy              = "SpotWithPriceLimit"
  resource_group_id          = alicloud_resource_manager_resource_group.altium.id

  system_disk {
    category             = "cloud_efficiency"
    name                 = var.launch_template_name
    size                 = "40"
    delete_with_instance = "true"
  }

  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    pkg_repository = var.pkg_repository
    pkg_name       = var.pkg_name
  }))

  tags = {
    Usage = var.tag
  }

  depends_on = [alicloud_ecs_key_pair.altium]
}

resource "alicloud_ess_scaling_group" "altium" {
  scaling_group_name = var.scaling_group_name
  min_size           = var.min_instances
  max_size           = var.max_instances
  default_cooldown   = 300
  vswitch_ids        = alicloud_vswitch.altium[*].id
  launch_template_id = alicloud_ecs_launch_template.altium.id
  health_check_type  = "ECS"
  resource_group_id  = alicloud_resource_manager_resource_group.altium.id

  tags = {
    Usage = var.tag
  }

  depends_on = [alicloud_ecs_launch_template.altium]
}

resource "alicloud_ess_scaling_rule" "scale_out" {
  scaling_group_id  = alicloud_ess_scaling_group.altium.id
  scaling_rule_name = "memory-scale-out"
  scaling_rule_type = "SimpleScalingRule"
  adjustment_type   = "QuantityChangeInCapacity"
  adjustment_value  = 1
  cooldown          = 60

  depends_on = [alicloud_ess_scaling_group.altium]
}

resource "alicloud_ess_scaling_rule" "scale_in" {
  scaling_group_id  = alicloud_ess_scaling_group.altium.id
  scaling_rule_name = "memory-scale-in"
  scaling_rule_type = "SimpleScalingRule"
  adjustment_type   = "QuantityChangeInCapacity"
  adjustment_value  = -1
  cooldown          = 60

  depends_on = [alicloud_ess_scaling_group.altium]
}


resource "alicloud_ess_alarm" "high_memory" {
  name                = "high-memory-alarm"
  alarm_actions       = [alicloud_ess_scaling_rule.scale_out.ari]
  scaling_group_id    = alicloud_ess_scaling_group.altium.id
  metric_type         = "system"
  metric_name         = "MemoryUtilization"
  period              = 120
  statistics          = "Average"
  threshold           = var.memory_high_threshold
  comparison_operator = ">="
  evaluation_count    = 2

  depends_on = [alicloud_ess_scaling_group.altium]
}

resource "alicloud_ess_alarm" "low_memory" {
  name                = "low-memory-alarm"
  alarm_actions       = [alicloud_ess_scaling_rule.scale_in.ari]
  scaling_group_id    = alicloud_ess_scaling_group.altium.id
  metric_type         = "system"
  metric_name         = "MemoryUtilization"
  period              = 120
  statistics          = "Average"
  threshold           = var.memory_low_threshold
  comparison_operator = "<="
  evaluation_count    = 2

  depends_on = [alicloud_ess_scaling_group.altium]
}

resource "alicloud_ess_alarm" "high_cpu" {
  name                = "high-cpu-alarm"
  alarm_actions       = [alicloud_ess_scaling_rule.scale_out.ari]
  scaling_group_id    = alicloud_ess_scaling_group.altium.id
  metric_type         = "system"
  metric_name         = "CpuUtilization"
  period              = 120
  statistics          = "Average"
  threshold           = var.cpu_high_threshold
  comparison_operator = ">="
  evaluation_count    = 2

  depends_on = [alicloud_ess_scaling_group.altium]
}

resource "alicloud_ess_alarm" "low_cpu" {
  name                = "low-cpu-alarm"
  alarm_actions       = [alicloud_ess_scaling_rule.scale_in.ari]
  scaling_group_id    = alicloud_ess_scaling_group.altium.id
  metric_type         = "system"
  metric_name         = "CpuUtilization"
  period              = 120
  statistics          = "Average"
  threshold           = var.cpu_low_threshold
  comparison_operator = "<="
  evaluation_count    = 2

  depends_on = [alicloud_ess_scaling_group.altium]
}
