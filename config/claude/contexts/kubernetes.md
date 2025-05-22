# Kubernetes Technical Context

This document provides technical context for Kubernetes-related tasks.

## Environment & Tools

- Kubernetes deployment: EKS (primary), colima (local development)
- Package management: Helm, kustomize
- GitOps: ArgoCD
- `kubectl` is aliased to `k` on my machine

## Kubernetes Best Practices

- Use namespaces for logical separation
- Implement resource requests and limits
- Use network policies for traffic control
- Follow the principle of least privilege with RBAC
- Implement pod security contexts
- Use ConfigMaps and Secrets for configuration

## Common Kubernetes Commands

- See aliases in ~/.config/zsh/.zshrc

```bash
# Context and namespace management
kubectx
kubens

# Resource management
k get pods
k describe deployment name
k logs pod-name
k exec -it pod-name -- bash
```
