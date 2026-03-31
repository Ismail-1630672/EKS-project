# Production-grade EKS-deployment

In this project the 2048 game-application is deployed onto Amazon EKS in a scalable, reliable and secure manner across multiple availability zones.

![image alt](https://github.com/Ismail-1630672/EKS-project/blob/7a3322de07c7071a532301021a31a06196dc0526/images/Screenshot%202026-03-29%20170718.png)

# Key features
- Helm: Deployed applications to EKS cluster
- NGINX ingress controller: Routes traffic to workloads within cluster.
- Cert-manager: Automatic issuance and renewal of certificates.
- External-DNS: Automatic management of records in route 53. 
- Argo CD: Watches Git repo to keep in sync with live cluster state for automatic application deployment.
- EBS-CSI-driver: Provides reliable storage for stateful workloads within cluster.
- Pod-identity: Assigns IAM roles to pods for secure access to AWS services without the use of static credentials.
- Prometheus & Grafana: Scrape cluster metrics and then visualise them using dashboards.

# Architecture diagram

![image alt](https://github.com/Ismail-1630672/EKS-project/blob/7e66ead2eae8dc22eab31e89d5db89ea8775eb3d/images/Screenshot%202026-03-31%20114815.png)

# Docker
- Used to containerise application for consistency and portability.
- Implemented docker layer caching to speed up builds.
- Multi-stage builds to reduce image size for faster deployments.
- Container ran as non-root user to minimise security risks.
- Immutable image tag used for more reproducible deployments.

# Terraform
- Applied the DRY principle using terraform modules (VPC, EKS, IAM) to create reusable and maintainable infrastructure code.
- Stored Terraform state in an Amazon S3 bucket with state locking enabled to ensure consistency and prevent corruption.

# Helm
- Used as a package manager to deploy and manage kubernetes applications via helm charts
- These include cert-manager, external-dns, argo cd and nginx-ingress.
- Integrated helmfile to deploy multiple helm releases with a single command promoting DRY principle.

# Argo CD - GitOps continuous delivery

![image alt](https://github.com/Ismail-1630672/EKS-project/blob/7a3322de07c7071a532301021a31a06196dc0526/images/Screenshot%202026-03-29%20170542.png)

- Implemented a GitOps workflow to continuously compare the desired state (git repo) with the live state (eks cluster).
- Kubernetes manifests (deployments, service, ingress) were stored in git and kept in sync with the live cluster.
- This ensured automated deployment of the application.

# Observability

Prometheus - Assisted with metric collection and monitoring of workloads within the cluster
![image alt](https://github.com/Ismail-1630672/EKS-project/blob/7a3322de07c7071a532301021a31a06196dc0526/images/Screenshot%202026-03-29%20184606.png)

Grafana - visualize metrics through dashboards, providing real-time insights into application and cluster performance.
![image alt](https://github.com/Ismail-1630672/EKS-project/blob/7a3322de07c7071a532301021a31a06196dc0526/images/Screenshot%202026-03-29%20190933.png)

# CI/CD Pipelines
- Seperate pipelines for pushing of image to ECR and deployment of infrastructure code via Terraform.
- Trivy was used to scan docker image for any vulnerabilities.
- Integrated checkov to detect security misconfigurations in Terraform code.
- Implemented OIDC for short-lived, automatically rotated credentials improving security posture.
![image alt](https://github.com/Ismail-1630672/EKS-project/blob/7e66ead2eae8dc22eab31e89d5db89ea8775eb3d/images/Screenshot%202026-03-31%20113319.png)






  




