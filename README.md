# AWS GitOps Platform

An end-to-end reference platform for provisioning and operating a containerized Django application on AWS. The repository demonstrates infrastructure as code, Kubernetes orchestration, CI/CD automation, GitOps delivery, managed databases, autoscaling, and observability.

## Architecture

```text
Developer push
    │
    ▼
Jenkins on EKS ── Kaniko build ──► Amazon ECR
    │                                   │
    └── updates Helm image tag          │
                    │                   │
                    ▼                   │
                 Argo CD ◄──────────────┘
                    │
                    ▼
        Django on Amazon EKS ──► Amazon RDS / Aurora
                    │
                    └── metrics ──► Prometheus / Grafana
```

## Technology Stack

- **Cloud:** AWS VPC, EKS, ECR, RDS/Aurora, S3, DynamoDB, IAM
- **Infrastructure as Code:** Terraform
- **Containers:** Docker, Kubernetes, Kaniko
- **Delivery:** Jenkins, Helm, Argo CD
- **Observability:** Prometheus, Grafana
- **Application:** Django, PostgreSQL, Nginx

## Repository Layout

```text
.
├── docker/                  # Django, Nginx, and local Docker Compose setup
├── terraform-foundation/   # Remote state, networking, and container registry
├── kubernetes-platform/    # VPC, EKS, ECR, and the application Helm chart
└── gitops-pipeline/         # Full CI/CD, GitOps, database, and monitoring stack
    ├── Jenkinsfile
    ├── charts/django-app/
    └── modules/
        ├── argo_cd/
        ├── ecr/
        ├── eks/
        ├── jenkins/
        ├── rds/
        └── vpc/
```

The directories represent progressively broader deployment scopes and can also be reviewed independently.

## Key Capabilities

- Reusable Terraform modules for VPC, EKS, ECR, Jenkins, Argo CD, and RDS/Aurora
- Remote Terraform state backed by S3 with DynamoDB locking
- Kubernetes-based Jenkins agents and daemonless image builds with Kaniko
- Declarative Helm deployment managed continuously by Argo CD
- Horizontal Pod Autoscaling from 2 to 6 replicas at 70% CPU utilization
- Switchable standard RDS and Aurora database implementations
- Prometheus metrics collection and Grafana dashboards
- Local multi-container development environment with Django, PostgreSQL, and Nginx

## Delivery Workflow

1. Jenkins checks out the default branch.
2. Kaniko builds the application image and pushes it to Amazon ECR.
3. The pipeline updates the image tag in the Django Helm values.
4. Argo CD detects the Git change and synchronizes the release to EKS.
5. Kubernetes performs the rollout and applies the configured autoscaling policy.

## Getting Started

### Prerequisites

- AWS CLI authenticated to a non-production AWS account
- Terraform 1.x
- Docker and Docker Compose
- `kubectl`
- Helm 3

### Local application

```bash
cd docker
cp .env.example .env
docker compose up --build
```

### Provision the platform

Copy the repository-specific examples into your own Terraform configuration before applying. Backend names, account IDs, credentials, database passwords, and GitHub settings must be provided through your own secure configuration.

```bash
cd gitops-pipeline
terraform init -backend-config=backend.hcl
terraform fmt -check -recursive
terraform validate
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

> AWS infrastructure can incur charges. Review the plan and destroy temporary environments when they are no longer needed.

### Verify the cluster

```bash
aws eks update-kubeconfig --region <aws-region> --name <cluster-name>
kubectl get nodes
kubectl get pods --all-namespaces
```

## Configuration and Security

- Keep `terraform.tfvars`, backend configuration, credentials, and local environment files out of version control.
- Supply GitHub credentials through Jenkins credentials and Terraform sensitive variables.
- Supply Django and database secrets through environment-specific secret management.
- Replace all example endpoints and identifiers before provisioning infrastructure.
- Restrict public access, IAM permissions, and security-group rules for production use.

This repository is a portfolio reference implementation, not a turnkey production environment. Production adoption requires dedicated state isolation, secret management, TLS, backup and restore policies, alerting, and a reviewed network-security model.

## Screenshots

| Component | Preview |
| --- | --- |
| Django application | ![Django application](django.png) |
| Jenkins pipeline | ![Jenkins pipeline](jenkins.png) |
| Argo CD | ![Argo CD dashboard](argocd.png) |
| RDS | ![Amazon RDS configuration](non-aurora-1.png) |
| Aurora | ![Amazon Aurora configuration](aurora.png) |
| Grafana | ![Grafana dashboard](grafana-2.png) |

## Validation

```bash
terraform fmt -check -recursive terraform-foundation kubernetes-platform gitops-pipeline
docker compose -f docker/docker-compose.yml config
```

## License

No license has been assigned. The source is available for portfolio review; reuse requires permission from the repository owner.
