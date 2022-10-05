# Terraforming_GCP

## Description
Welcome to all fellow readers trying to deploy a GKE cluster using Terraform! Here you will find a quick guide on how to properly deploy said cluster using Terraform best practices and existing Terraform modules created by Google itself.
Of course, some basic knowledge about Terraform is expected as this article isn't going to explain what Terraform is but it certainly will detail which commands to run in order to deploy what we want in the way we want to.

## Key Topics
- `Google Cloud Platform`
    - GCP is a Public Cloud when we will deploy the Kubernetes Cluster with all the other resources needed to be functional.
- `Terraform`
    - Open-source IaC (Infrastructure as Code) software tool that we will use to deploy the cluster. 

## Prerequisites
- `GCP` account created and with billing enabled.
    - `gcloud` installed on your computer is optional.
- `terraform` installed on your computer.

## Provision GKE cluster with Terraform

### GCP account set up
Lorem ipsum dolor sit amet.

### Provisioning a cluster with Terraform
### Create dev GKE cluster
- Go to the working directory `gcp/gke-deployment` and run the `terraform version` command.
``` 
cd gke/gke-deployment
terraform version
```

You should see something like this:
``` 
Terraform v1.1.6
on darwin_arm64
+ provider registry.terraform.io/hashicorp/google v4.34.0
+ provider registry.terraform.io/hashicorp/google-beta v4.38.0
+ provider registry.terraform.io/hashicorp/kubernetes v2.13.1
+ provider registry.terraform.io/hashicorp/local v2.2.3
+ provider registry.terraform.io/hashicorp/random v3.4.3

Your version of Terraform is out of date! The latest version
is 1.3.1. You can update by downloading from https://www.terraform.io/downloads.html
```

- Later, initliaze Terraform running this command:
`terraform init`

To be continued...