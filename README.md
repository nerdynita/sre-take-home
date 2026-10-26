# SRE Internship Take-Home Project: Nginx Web Server on AWS with Terraform

This project uses Terraform to create a web server in the AWS cloud. It is an EC2 instance running nginx and reachable by HTTP from your own IP address.


## What it creates
- An EC2 instance (`t3.micro`, Amazon Linux 2023).
- A security group with two rules: inbound TCP on port 80 from your IP and all outbound traffic.
- A startup script (`user_data.sh`) that installs and starts nginx.
- A `public_ip` output with the server's IP address.

## Prerequisites
- Create an [AWS Free Tier account](https://aws.amazon.com/free/)
- Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- AWS credentials on your machine: an IAM user with EC2 permissions and an access key, set up with `aws configure` using the [AWS CLI](https://docs.aws.amazon.com/cli/). These credentials are needed by Terraform to create resources.

## How to run
1. Clone this repo
2. Rename `terraform.tfvars.example` to `terraform.tfvars` and replace the example `my_ip` variable with your public IP address. Find your IP using the `curl checkip.amazonaws.com` command. Remember to add `/32` at the end so only your IP can reach the server.
3. `terraform init`.
4. `terraform validate`.
5. `terraform plan`.
6. `terraform apply`. This will print a `public_ip` output, the public IP address of your web server.
7. Paste the output IP address into your browser to view the nginx page: `http://<public_ip>`.
8. `terraform destroy` when finished.

## Result
Pasting the public IP address into your browser should bring you to a page that looks like this:
![Welcome to nginx page](./docs/nginx-welcome.png)

## Notes

## Resources used
- [Terraform `aws_instance`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [Terraform `aws_security_group`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
- [AWS EC2 user data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)
- [Terraform outputs tutorial](https://developer.hashicorp.com/terraform/tutorials/configuration-language/outputs)
