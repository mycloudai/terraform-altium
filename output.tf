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

output "launch_template_id" {
  value       = alicloud_ecs_launch_template.altium.id
}

output "scaling_group_id" {
  value       = alicloud_ess_scaling_group.altium.id
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
