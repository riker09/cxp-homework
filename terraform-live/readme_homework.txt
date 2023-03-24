Session: 2023-03-03 Terraform@AWS II

Agenda
 - Presentation of Assignments (A-Team, DarkSide)
 - Presentation: AWS DNS with Route53
  (see: https://d11ec2722rad1b.cloudfront.net/aws/route53/dns_basics.html)
 - Presentation: Infrastructure as Code with Terraform
  (see: https://d11ec2722rad1b.cloudfront.net/iac/index.html)
  (see: Cloud-Infrastructure-as-Code-with-Terraform_EN.pdf)
 - Hand-out of assignments
 - Wrap-up

Links:
 - https://developer.hashicorp.com/terraform/language
 - https://registry.terraform.io/providers/hashicorp/aws/latest/docs
What's new?

TODOs
- Assignment 28: Create a simple VPC with an Internet Gateway and public subnets using Terraform. Destroy all infrastructure using Terraform.
(all teams)
- Assignment 29: Extend your Terraform code base by dropping an EC2 instance in one of the public subnets of the previously created VPC. Add a specific security group to the EC2. The EC2 instance must be accessible via SSH. Destroy all infrastructure using Terraform.
(all teams)
- Assignment 30: Improve your Terraform code base by installing NGinX on your EC2 instance using EC2 user data. NGinX must be accessible using HTTP. Destroy all infrastructure using Terraform.
(all teams)
- Assignment 31: Switch your Terraform project to a remote backend based on AWS S3 and DynamoDB as shown in the presentation using Terraform module at git::https://github.com/msgoat/iac-tf-aws-cloudtrain-modules.git//modules/terraform/remote-state. Don't forget to destroy everything before moving to remote state! Recreate everything. NGinX must be accessible using HTTP. Destroy all infrastructure using Terraform.
(all teams)
- Assignment 32: Refactor your Terraform code by extracting modules for networks and for EC2 instances. Don't forget to destroy everything before moving Terraform code to modules! Recreate everything. NGinX must be accessible using HTTP. Destroy all infrastructure using Terraform.
(all teams)
- (not needed!) Assignment 33: Add a new module for DNS to your Terraform code base which creates a hosted zone for your solutions which contains all DNS records pointing to your EC2 machines. The domain Domain name is: <team>.cxp.aws.msgoat.eu. A parent public hosted zone serving *.cxp.aws.msgoat.eu will be provided. Recreate everything. NGinX must be accessible using the DNS name nginx.<team>.cxp.aws.msgoat.eu. Destroy all infrastructure using Terraform.
(all teams)
- Assignment 34: Split your Terraform code base into two separate directories: one for the module code, one for the live code. Reorganize the live code as shown in the presentation. Make it run! Destroy all infrastructure using Terraform.
(all teams)

------------------------------------------------------------
Session: 2023-03-10 AWS IV, Terraform@AWS III

Agenda
 - Presentation of Assignments (A-Team, Breaking AWS)
 - Presentation: AWS DNS with Route53
    (see: https://d11ec2722rad1b.cloudfront.net/aws/route53/dns_basics.html)
 - Presentation: AWS VPC Reference Blueprint
    (see: https://d11ec2722rad1b.cloudfront.net/aws/vpc/vpc_blueprint.html)
 - Presentation: AWS Extended Networking
    (see: https://d11ec2722rad1b.cloudfront.net/aws/vpc/vpc_extended_networking.html)
 -  Presentation: Infrastructure as Code with Terraform
    (see: https://d11ec2722rad1b.cloudfront.net/iac/index.html)
    (see: Cloud-Infrastructure-as-Code-with-Terraform_EN.pdf)

Links:
    https://developer.hashicorp.com/terraform/language
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs

Assignment 34: Add a new module for DNS to your Terraform code base which creates a hosted zone for your solutions which contains all DNS records pointing to your EC2 machines. The domain Domain name is: <team>.cxp.aws.msgoat.eu. A parent public hosted zone serving *.cxp.aws.msgoat.eu will be provided. Recreate everything. NGinX must be accessible using the DNS name nginx.<team>.cxp.aws.msgoat.eu. Destroy all infrastructure using Terraform.
(all teams)
Assignment 35: Using Terraform: Create two VPCs with public and private subnets. Drop an EC2 in the public subnet of VPC 1. Drop an EC2 in the private subnet of VPC 2. Connect both VPC via VPC peering. Make sure the EC2 in VPC 1 can access the EC2 in VPC 2 via SSH using VPC peering. Make it run! Destroy all infrastructure using Terraform.
(all teams)