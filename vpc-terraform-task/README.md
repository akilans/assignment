# Create AWS VPC using Terraform

- Use Terraform to create VPC using best practices with your own CIDR choice

### Network module

- input variables - region,env,vpc_name,vpc_cidr_range,subnets(map(string))
- create vpc
- create subnets in each AZ
- create internet gateway
- attach internet gateway to default route table for the new vpc
- outputs - newly created vpc_id as string & subnets as list
