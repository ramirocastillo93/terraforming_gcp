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
```
If you don't see any messages regarding an older version of Terraform then you are good to go.

- Later, initliaze Terraform running this command:
`terraform init`

And you should se something like this:
```
Initializing modules...

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/random from the dependency lock file
- Reusing previous version of hashicorp/google-beta from the dependency lock file
- Reusing previous version of hashicorp/google from the dependency lock file
- Reusing previous version of hashicorp/local from the dependency lock file
- Reusing previous version of hashicorp/kubernetes from the dependency lock file
- Using previously-installed hashicorp/random v3.4.3
- Using previously-installed hashicorp/google-beta v4.38.0
- Using previously-installed hashicorp/google v4.34.0
- Using previously-installed hashicorp/local v2.2.3
- Using previously-installed hashicorp/kubernetes v2.13.1

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
This will install all the dependencies that Terraform needs to use in order to work in a proper way. Keep in mind that everytime you use a new module or try to use a new provider, you will have to run this command again. 

The next step is to format and validate your Terraform code:
```
terraform fmt -recursive
terraform validate
```
The `-recursive` command will allow you every subfolder inside your main folder, so I strongly recommend to use this on your parent folder.

Once this is done, is time to `plan` and then `apply`.
```
terraform plan -var-file=dev.tfvars -out=dev_output.json
```
With the previous command Terraform will show you what it is supposed to do and then save that action plan into a file that will be used again with `terraform apply`
```
terraform apply dev_output.json
```
(Keep in mind that the 'dev_output.json' should be 'prod_output.json' in a production environment)

You'll see something like this

```
module.gke.google_container_node_pool.pools["onlineboutique-dev-node-pool"]: Still creating... [30s elapsed]
module.gke.google_container_node_pool.pools["onlineboutique-dev-node-pool"]: Still creating... [40s elapsed]
module.gke.google_container_node_pool.pools["onlineboutique-dev-node-pool"]: Still creating... [50s elapsed]
module.gke.google_container_node_pool.pools["onlineboutique-dev-node-pool"]: Still creating... [1m0s elapsed]
module.gke.google_container_node_pool.pools["onlineboutique-dev-node-pool"]: Still creating... [1m10s elapsed]
module.gke.google_container_node_pool.pools["onlineboutique-dev-node-pool"]: Still creating... [1m20s elapsed]
module.gke.google_container_node_pool.pools["onlineboutique-dev-node-pool"]: Still creating... [1m30s elapsed]
module.gke.google_container_node_pool.pools["onlineboutique-dev-node-pool"]: Creation complete after 1m33s [id=projects/developing-stuff/locations/us-east4/clusters/onlineboutique-dev/nodePools/onlineboutique-dev-node-pool]
module.gke_auth.data.google_client_config.provider: Reading...
module.gke_auth.data.google_client_config.provider: Read complete after 0s [id=projects/developing-stuff/regions/us-east4/zones/]
module.gke_auth.data.google_container_cluster.gke_cluster: Reading...
module.gke_auth.data.google_container_cluster.gke_cluster: Read complete after 6s [id=projects/developing-stuff/locations/us-east4/clusters/onlineboutique-dev]
local_file.kubeconfig: Creating...
local_file.kubeconfig: Creation complete after 0s [id=5554e0410c1b5e9061efb3b41cb068248e616c6d]

Apply complete! Resources: 12 added, 0 changed, 0 destroyed.
```
As you can see, Terraform added 12 new resources to GCP. Those new resources are the ones in the `main.tf` file. 

Notice that after you run this command a new file called `kubeconfig-{env}` is created containing the credentials to the cluster.

