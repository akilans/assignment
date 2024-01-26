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
```
