# cloudflare generate ssl
<img alt="Alt text" src="image/cloudflare_ssl.png" />

# aliyun create RAM user
<img alt="Alt text" src="image/aliyun_ram.png" />


# terraform
DOC: https://registry.terraform.io/providers/aliyun/alicloud/latest/docs

- ssl: cert generate from cloudflare
- data.tf: get needed data
- vpc.tf: create vpc, vswitch
- sg.tf: create security group
- key.tf: create key pair
- db.tf: create db ecs
- asg.tf: create autoscaling group, rule,alarm
- alb.tf: create alb, server group, listener

```
export TF_VAR_access_key='xxx'
export TF_VAR_secret_key='xxx'
export TF_VAR_allowed_ip_addresses='["10.0.0.0/8","16.0.0.0/8","149.0.0.0/8"]'

terraform init
terraform plan
terraform apply --auto-approve
data.dns_a_record_set.example_com: Reading...
...
alicloud_alb_listener.altium: Creation complete after 25s [id=lsn-uz3nv15zgasw2aol3n]

Apply complete! Resources: 2 added, 1 changed, 0 destroyed.

Outputs:

alb_dns_name = "alb-8spmn0s34shb88t0gb.cn-hongkong.alb.aliyuncsslbintl.com"
alb_id = "alb-8spmn0s34shb88t0gb"
alicloud_images = tolist([
  {
    "architecture" = "x86_64"
    "creation_time" = "2025-05-29T12:17:29Z"
    "description" = "Kernel version is 6.8.0-60-generic, 2025.5.29"
    "disk_device_mappings" = tolist([])
    "id" = "ubuntu_24_04_x64_20G_alibase_20250527.vhd"
    "image_id" = "ubuntu_24_04_x64_20G_alibase_20250527.vhd"
    "image_owner_alias" = "system"
    "image_version" = "v2025.5.29"
    "is_copied" = false
    "is_self_shared" = ""
    "is_subscribed" = false
    "is_support_io_optimized" = true
    "name" = "ubuntu_24_04_x64_20G_alibase_20250527.vhd"
    "os_name" = "Ubuntu  24.04 64位"
    "os_name_en" = "Ubuntu  24.04 64 bit"
    "os_type" = "linux"
    "platform" = "Ubuntu"
    "product_code" = ""
    "progress" = "100%"
    "size" = 20
    "state" = "Available"
    "status" = "Available"
    "tags" = tomap({})
    "usage" = "instance"
  },
])
db_id = "i-j6ch4fpmzp859aa5zprg"
db_private_ip = "10.0.1.128"
high_cpu_alarm_id = "asg-j6c5a5luk91g5qhjfrho_f1c753aa-61eb-4f81-8272-7afac7109590"
high_memory_alarm_id = "asg-j6c5a5luk91g5qhjfrho_56314691-b919-4f5a-9a0a-f650ea27fc92"
https_listener_id = "lsn-uz3nv15zgasw2aol3n"
key_pair_name = "keypair-altium"
launch_template_id = "lt-j6c38b6mj5lsre8bfz2z"
low_cpu_alarm_id = "asg-j6c5a5luk91g5qhjfrho_093fe150-1080-4983-95aa-511043d8dc29"
low_memory_alarm_id = "asg-j6c5a5luk91g5qhjfrho_7ad1f468-320e-42c8-ac5e-b6afa5e764e5"
private_key = <sensitive>
public_key = <sensitive>
resource_group_id = "rg-aek2mxk4wzqlgmi"
scale_in_rule_ari = "ari:acs:ess:cn-hongkong:1914098474693033:scalingrule/asr-j6c5a5luk91g5qhhl0fz"
scale_out_rule_ari = "ari:acs:ess:cn-hongkong:1914098474693033:scalingrule/asr-j6cj07qmt0fdo3x64obw"
scaling_group_id = "asg-j6c5a5luk91g5qhjfrho"
security_group_app_id = "sg-j6cio598fk2a8m0cni95"
security_group_db_id = "sg-j6c5h7dj98la1tijwgx9"
server_group_id = "sgp-hahkcr4vpjbtj5xj06"
ssl_certificate_id = "19041060"
vpc_id = "vpc-j6cdc06lwpr3dmes53gk0"
vswitch_ids = [
  "vsw-j6cp7r9id17u1h2j449pb",
  "vsw-j6cg0b5wmx02fn6gfhza4",
  "vsw-j6cdktcod7nawxwf379n9",
]
```

generate key for debug ecs
```
terraform output private_key > key.pem
```


# cloudflare create record
<img alt="Alt text" src="image/cloudflare_record.png" />

# POC infrastructure
```
terraform graph | dot -Tsvg > image/terraform_graph.svg
```
<img alt="Alt text" src="image/terraform_graph.svg" />

# access web
access web via cloudflare dns name
<img alt="Alt text" src="image/web_dns.png" />