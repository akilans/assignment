# Assignment

- Create a sample application to print “Welcome to 2022”and user agent info using any programming language.
- Create a VPC in AWS with your own CIDR choice using best practices.
- Build your application and create container image to deploy your application.
- Deploy your application using any type of automated pipeline on AWS EKS

# Task 1

- Golang web application to show “Welcome to 2022”and user agent info
- Add /health route - it is used to configure liveness and readiness probe in k8s
- Use multistage dockerbuild to reduce image size

```bash
# Install go & Test locally
cd app
go run main.go
# access http://localhost:8080 & http://localhost:8080/health

# build docker image, test it by running a container and push it to AWS ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 738418786830.dkr.ecr.ap-south-1.amazonaws.com

docker image build -t 738418786830.dkr.ecr.ap-south-1.amazonaws.com/sample-app:v1 .

# test it locally
docker container run -d --name sample-app -p 8080:8080 738418786830.dkr.ecr.ap-south-1.amazonaws.com/sample-app:v1
# access http://localhost:8080 & http://localhost:8080/health
# remove container
docker container stop sample-app && docker container rm sample-app
# push docker image to ECR
docker image push 738418786830.dkr.ecr.ap-south-1.amazonaws.com/sample-app:v1
```

![Sample app Demo](https://raw.githubusercontent.com/akilans/assignment/main/images/sample-app.png)

# Task 2

- Create a VPC in AWS with your own CIDR choice using best practices
- Create subnets in all AZs
- Create internet gateway
- Attach internet gateway to default route table of newly created VPC

```bash
# Before running configure backend for storing state file
# Used S3 bucket and DynamoDB table to store state file in remote backend
# Create all the resources
cd vpc-terraform-task
terraform init
terraform validate
terraform plan
terraform apply
```

![Terraform VPC Demo](https://raw.githubusercontent.com/akilans/assignment/main/images/terraform-vpc.gif)

# Task 3

- Create a EKS cluster in AWS by eksctl cli tool
- Create k8s manifest file for the sample app deployment
- Expose the app via loadbalancer
- Access the app

```bash
cd eks
eksctl create cluster -f cluster.yaml
eksctl get cluster
eksctl get nodegroup --cluster eks-test-1
aws eks update-kubeconfig --region ap-south-1 --name eks-test-1
kubectl apply -f manifest.yaml
kubectl get pods
kubectl get svc
# access the loadbalancer http://abd966080f82943ca9cd41e100bcd64e-1313186370.ap-south-1.elb.amazonaws.com
```

![EKS Demo](https://raw.githubusercontent.com/akilans/assignment/main/images/eks.png)
