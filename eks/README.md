# AWS EKS

### Pre-Requisites

- AWS Cli
- kubectl
- eksctl

### Create EKS cluster & run application

```bash
eksctl create cluster -f cluster.yaml
eksctl get cluster
eksctl get nodegroup --cluster eks-test-1
aws eks update-kubeconfig --region ap-south-1 --name eks-test-1
kubectl apply -f manifest.yaml
kubectl get pods
kubectl get svc
# access the loadbalancer http://abd966080f82943ca9cd41e100bcd64e-1313186370.ap-south-1.elb.amazonaws.com

TRUST="{ \"Version\": \"2012-10-17\", \"Statement\": [ { \"Effect\": \"Allow\", \"Principal\": { \"AWS\": \"arn:aws:iam::738418786830:root\" }, \"Action\": \"sts:AssumeRole\" } ] }"

echo '{ "Version": "2012-10-17", "Statement": [ { "Effect": "Allow", "Action": "eks:Describe*", "Resource": "*" } ] }' > /tmp/iam-role-policy

aws iam create-role --role-name CodeBuildKubectlRole --assume-role-policy-document "$TRUST" --output text --query 'Role.Arn'

aws iam put-role-policy --role-name CodeBuildKubectlRole --policy-name eks-describe --policy-document file:///tmp/iam-role-policy


ROLE="    - rolearn: arn:aws:iam::738418786830:role/CodeBuildKubectlRole\n      username: build\n      groups:\n        - system:masters"

kubectl get -n kube-system configmap/aws-auth -o yaml | awk "/mapRoles: \|/{print;print \"$ROLE\";next}1" > /tmp/aws-auth-patch.yml

kubectl patch configmap/aws-auth -n kube-system --patch "$(cat /tmp/aws-auth-patch.yml)"


```
