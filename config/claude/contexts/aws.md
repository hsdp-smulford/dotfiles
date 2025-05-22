# AWS Technical Context

This document provides technical context for AWS-related tasks.

## Environment & Tools

- AWS (primary), multi-account strategy, Well-Architected Framework
- Terraform (HCL), AWS CDK, terragrunt for multi-environment
- Security tools: AWS Security Hub, Config, GuardDuty
- `terraform` is aliased as `t` in my envirment
- always look for a `.terraform-version` file and then `tenv` it

## AWS Best Practices

- Follow infrastructure as code principles using Terraform
- Use multi-account strategy with Organization SCPs
- Implement least privilege for all IAM roles and policies
- Encrypt all data at rest and in transit
- Enable CloudTrail and centralize logs

## Common AWS Commands

```bash
# Profile management
## function in ~/.config/zsh/.zshrc to log into an aws account:
al shawn-dev
aws whoami

# EKS commands
read -p "RESOURCE_PREFIX? Enter env name: "

aws eks update-kubeconfig \
  --name "${RESOURCE_PREFIX}-cluster" \
  --alias "${RESOURCE_PREFIX}" \
  --user-alias "${RESOURCE_PREFIX}"
```
