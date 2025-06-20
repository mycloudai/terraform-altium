# DevOps Task
Design solution that would address automation deployment with inbound and outbound traffic restriction, prepare POC of solution in Terraform for Ali Cloud.
Below is an overview of the current situation in the project
Inside VPC there is an application running and it consist of :
- ECS Linux app instance ( single ECS instance inside Auto Scaling Group )
- ECS Linux MySQL instance
- 3 vswitches used in default VPC available for instance and ALB.
- ALB with external IP and SSL cert attached.
- Security groups have default outbound config, allow inbound 80 from 0.0.0.0/0
- Instance on startup ( user-data ) installs one package from repository example.com, if not installed application running on instance won’t start
For the daily operation instance needs to communicate with secureweb.com over https.
Inbound traffic should be limited to a list of IP addresses ( finite )
All items were created manually, and no automation exists that manage infrastructure.

## TASK 1:
- Create Terraform Code of an infrastructure with POC ( include all ECS instances and
ALB, SG, ESS, VPC, vswitches … )
- Create Simple diagram of POC infrastructure
- ESS can be based on CPU/Memory threshold
- Prepare for discussion about POC.

## TASK 2 (Optional)：
Think about how to implement zero-downtime deployment architecture based on your solution (TASK1).