# Terraforming_GCP

## Description
Welcome to all fellow readers trying to deploy a GKE cluster using Terraform! Here you will find a quick guide on how to properly deploy said cluster using Terraform best practices and existing Terraform modules created by Google itself.
Of course, some basic knowledge about Terraform is expected as this article isn't going to explain what Terraform is but it certainly will detail which commands to run in order to deploy what we want in the way we want to.

In this case, we will deploy an Online Boutique store.

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
The firs step of this journey is to set up Google Cloud SDK on your computer (or whatever machine you are using). This SDK has all the resources and tools Terraform will need to perform all the tasks you want. 

Please follow this instructions in order to install it: https://cloud.google.com/sdk/docs/install

Next, run these commands to check everything is working fine:
```
gcloud --version
gcloud init
```
This will prompt a page when you will have to login into your GCP account credentials.

After that please run
```
gcloud auth application-default login
```

Now we should enable all the APIs that GCP will use in order to allow Terraform to create what is needed:
```
gcloud components update
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
```

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


# Terraform Modules 
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.34.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster | = 23.1.0 |
| <a name="module_gke_auth"></a> [gke\_auth](#module\_gke\_auth) | terraform-google-modules/kubernetes-engine/google//modules/auth | n/a |
| <a name="module_gke_vpc"></a> [gke\_vpc](#module\_gke\_vpc) | terraform-google-modules/network/google | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name for the GKE cluster | `string` | n/a | yes |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | The environment for the GKE cluster | `string` | `"dev"` | no |
| <a name="input_gke_cluster_autoscaling"></a> [gke\_cluster\_autoscaling](#input\_gke\_cluster\_autoscaling) | Object with information for enabling GKE cluster autoscaling | <pre>object({<br>    enabled        = bool<br>    cpu_minimum    = number<br>    cpu_maximum    = number<br>    memory_minimum = number<br>    memory_maximum = number<br>  })</pre> | <pre>{<br>  "cpu_maximum": 4,<br>  "cpu_minimum": 2,<br>  "enabled": true,<br>  "memory_maximum": 16,<br>  "memory_minimum": 4<br>}</pre> | no |
| <a name="input_gke_disabled_hpa"></a> [gke\_disabled\_hpa](#input\_gke\_disabled\_hpa) | Boolean. Is HPA disabled? | `bool` | `true` | no |
| <a name="input_gke_disabled_vpa"></a> [gke\_disabled\_vpa](#input\_gke\_disabled\_vpa) | Boolean. Is VPA disabled? | `bool` | `true` | no |
| <a name="input_gke_machine_type"></a> [gke\_machine\_type](#input\_gke\_machine\_type) | GKE machine type | `string` | `""` | no |
| <a name="input_gke_num_nodes"></a> [gke\_num\_nodes](#input\_gke\_num\_nodes) | Number of GKE nodes | <pre>object({<br>    min = number<br>    max = number<br>  })</pre> | <pre>{<br>  "max": 2,<br>  "min": 1<br>}</pre> | no |
| <a name="input_gke_preemptible"></a> [gke\_preemptible](#input\_gke\_preemptible) | Boolean variable for setting preemtible machines or not on GKE cluster | `bool` | `true` | no |
| <a name="input_gke_subnet_ip_cidr_range"></a> [gke\_subnet\_ip\_cidr\_range](#input\_gke\_subnet\_ip\_cidr\_range) | ip cidr range for gcp subnet | `string` | `""` | no |
| <a name="input_ip_range_pods_name"></a> [ip\_range\_pods\_name](#input\_ip\_range\_pods\_name) | Name of the IP range pods name | `string` | `"ip_range_pods_name"` | no |
| <a name="input_ip_range_services_name"></a> [ip\_range\_services\_name](#input\_ip\_range\_services\_name) | Name of the IP services pods name | `string` | `"ip_range_services_name"` | no |
| <a name="input_network"></a> [network](#input\_network) | The VPC network created to host the cluster in | `string` | `"gke-network"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project id | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `""` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The subnetwork created to host the cluster in | `string` | `"gke-subnet"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->