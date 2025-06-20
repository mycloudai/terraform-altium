output "resource_group_id" {
  value       = alicloud_resource_manager_resource_group.altium.id
}

output "vpc_id" {
  value       = alicloud_vpc.altium.id
}

output "vswitch_ids" {
  value       = alicloud_vswitch.altium[*].id
}

output "security_group_app_id" {
  value       = alicloud_security_group.app.id
}

output "security_group_db_id" {
  value       = alicloud_security_group.db.id
}

output "key_pair_name" {
  value       = alicloud_ecs_key_pair.altium.key_pair_name
}

output "private_key" {
  value       = tls_private_key.altium.private_key_pem
  sensitive   = true
}

output "public_key" {
  value       = tls_private_key.altium.public_key_openssh
  sensitive   = true
}

output "db_id" {
  value       = alicloud_instance.altium.id
}

output "db_private_ip" {
  value       = alicloud_instance.altium.private_ip
}

output "alicloud_images" {
  value       = data.alicloud_images.default.images
}

output "launch_template_id" {
  value       = alicloud_ecs_launch_template.altium.id
}

output "scaling_group_id" {
  value       = alicloud_ess_scaling_group.altium.id
}

output "scale_out_rule_ari" {
  value       = alicloud_ess_scaling_rule.scale_out.ari
}

output "scale_in_rule_ari" {
  value       = alicloud_ess_scaling_rule.scale_in.ari
}

output "high_memory_alarm_id" {
  value       = alicloud_ess_alarm.high_memory.id
}

output "low_memory_alarm_id" {
  value       = alicloud_ess_alarm.low_memory.id
}

output "high_cpu_alarm_id" {
  value       = alicloud_ess_alarm.high_cpu.id
}

output "low_cpu_alarm_id" {
  value       = alicloud_ess_alarm.low_cpu.id
}

output "ssl_certificate_id" {
  value       = alicloud_ssl_certificates_service_certificate.altium.id
}

output "alb_dns_name" {
  value       = alicloud_alb_load_balancer.altium.dns_name
}

output "alb_id" {
  value       = alicloud_alb_load_balancer.altium.id
}

output "server_group_id" {
  value       = alicloud_alb_server_group.altium.id
}

output "https_listener_id" {
  value       = alicloud_alb_listener.altium.id
}
