# Terraforming_GCP

## Description
Welcome to all fellow readers trying to deploy a GKE cluster using Terraform! Here you will find a quick guide on how to properly deploy said cluster using Terraform best practices and existing Terraform modules created by Google itself using Github Actions as the CI/CD platform.

Of course, some basic knowledge about Terraform and CI/CD is expected as this article isn't going to explain what these technologies are in detail but it certainly will detail which commands to run in order to deploy what we want in the way we want to.

We will be deploying three main Terraform modules that will provision the resources that we want in order to make the Online Boutique store functioning properly:
- [`GKE Module`](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine#terraform-kubernetes-engine-module)
    - Module to create a GKE cluster and the Node Pools. It will allow us to enable cluster autoscaling, HPA y VPA. 
- [`GCP VPC`](https://github.com/terraform-google-modules/terraform-google-network#terraform-network-module)
    - This module makes it easy to set up a new VPC Network in GCP by defining your network and subnet ranges in a concise syntax.
- [`GKE Auth`](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/tree/master/modules/auth#terraform-kubernetes-engine-auth-module)
    - This module allows configuring authentication to a GKE cluster using an OpenID Connect token retrieved from GCP as a kubeconfig file or as outputs intended for use with the kubernetes / helm providers.
    This module retrieves a token for the account configured with the google provider as the Terraform runner using the provider's credentials, access_token, or other means of authentication.


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

```
gcloud container clusters get-credentials onlineboutique-dev --region us-east4 --project developing-stuff
```

You'll see something like this
```
Fetching cluster endpoint and auth data.
CRITICAL: ACTION REQUIRED: gke-gcloud-auth-plugin, which is needed for continued use of kubectl, was not found or is not executable. Install gke-gcloud-auth-plugin for use with kubectl by following https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
kubeconfig entry generated for onlineboutique-dev.
```

Then export the kubeconfig file:
```
export KUBECONFIG=./kubeconfig-dev # Please write the complete directory
export KUBE_CONFIG_PATH=./kubeconfig-dev # Please write the complete directory
```

# Directory Tree
```
├── LICENSE
├── README.md
└── gcp
    └── gke-deployment
        ├── dev.tfvars
        ├── dev_output.json
        ├── main.tf
        ├── prod.tfvars
        ├── providers.tf
        ├── variables.tf
        └── version.tf
```

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


# Github Actions
Github Actions is a continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test and deployment pipeline with every push or pull request to your repository.

If you want to learn more about it, [check this link out ](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions).

## First Step
We will be creating a new folder called `.github` with a subfolder in it called `workflows`. Inside of it we will create a new file called `main.yaml` that will have all the configurations to run the CI/CD pipeline.

Remember that if you don't create this folder, Github will have no idea that there is a plan to use its Actions.

Next, you'll have to create a service account and download its key in order to use it as a secret and give the pipeline the correct credentials. If you don't, Terraform will not be able to do its magic.

## Tree
```
.github
└── workflows
    └── deploy-gke-dev.yaml
    └── deploy-gke-prod.yaml
    └── deploy-gke-template.yaml
```

## Explanation of deploy-gke-template.yaml
This is a reusable workflow that will be later be used for deployment in different environments by referencing this template in your other workflows files. In this case, prod and dev. 

This feature allow us to pass some inputs and secrets at the beginning of the workflow so we don't repeat code and run the same workflow on different environments. 

Let's explain the workflow itself:

```
on:
  workflow_call:
    inputs:
      deployment_directory:
        required: true
        type: string
      env:
        required: true
        type: string
    secrets:
      google_credentials:
        required: true
```
The `workflow_call` is the trigger that will make this template reusable. Init we have `inputs` and `secrets`. The `inputs` are the normal data that you can pass. In this case we are passing two inputs: `env` and `deployment_directory`. This will allow us to run the same workflow for different deployments on multiple environments. 
At the end we have the `google_credentials` secret that we must define and upload as an [Action Secret on yout GitHub account](https://docs.github.com/en/enterprise-cloud@latest/actions/security-guides/encrypted-secrets). 

Then the definition of the workflow jobs begins:
```
jobs:
  terraform-init-validate-plan-build:
    name: "Terraform"
    runs-on: ubuntu-latest
    env: 
      GOOGLE_CREDENTIALS: ${{ secrets.google_credentials }}
    defaults:
      run:
        working-directory: ${{ inputs.deployment_directory }}
```
You'll have to `name` the job, define where it will run with `runs-on` (ubuntu-latest for this example), define an `env` variable called `GOOGLE_CREDENTIALS` and the working directory (in this case `gcp/gke-deployment`).

After this initial configuration, there comes a series of steps that are pretty self explanatory. 

The first step is the checkout that will allow the workflow to use a copy of the repository:
```
steps:
    - name: Checkout
      uses: actions/checkout@v2
```

The second one will install all the Terraform dependencies on the runner so we can run it on the Github runner.
```
- name: Setup Terraform
  uses: hashicorp/setup-terraform@v1
```

In the next ones we will start using Terraform commands:
```
- name: Run Terraform Init
  run: terraform init

- name: Run Terraform Format
  run: terraform fmt -recursive -check 

- name: Run Terraform Plan
  run: terraform plan -var-file=${{ inputs.env }}.tfvars -out=${{ inputs.env }}.tfplan -lock=false
```
Notice the `Run Terraform Plan` step has a `-var-file=${{ inputs.env }}`.tfvars attribute and an `-out=${{ inputs.env }}.tfplan`. Depending on the `env` that you will pass when you reference this workflow, Terraform will do its magic. For example, if you pass as `env` the value `prod` Terraform will run:
```
- name: Run Terraform Plan
  run: terraform plan -var-file=prod.tfvars -out=prod.tfplan -lock=false
```
Meaning that will use the file `prod.tfvars` (that should have all the prod variables) and will output the plan into a `prod.tfplan` file that will then be used for in the Terraform Apply step:
```
- name: Run Terraform Apply
  if:
      (github.ref == 'refs/head/main' && github.event_name == 'push') || (github.event_name == 'release')
  run: terraform apply -auto-approve ${{ inputs.env }}.tfplan
```
This step has the `if` statement. It will tell this step to only be run if there is a push the main branch or there is a release.
It will use the output file that was saved on the previous step.

### Call the reusable workflow
You will have as many workflow files as environments you have. Each workflow file should have its rules to be run on, such as "on every pull request in every branch with changes on a specific folder" or "at every new release".

Let's check the `deploy-gke-dev.yaml` workflow file:
```
name: Deploying GKE with Terraform (Dev)

on:
  pull_request:
    branches:
      - main
      - 'feature/*'
      - 'hotifx/*'
    paths:
      - gcp/gke-deployment/**

jobs:
  TF_Deploy_Dev:
    uses: ramirocastillo93/terraforming_gcp/.github/workflows/deploy-gke-template.yml@feature/github-actions
    with:
      deployment_directory: gcp/gke-deployment
      env: dev
    secrets:
      google_credentials: ${{ secrets.GOOGLE_CREDENTIALS }}
```
It's rather simple. As you can see, you will first define when this workflow should be executed. In this case (for dev) it will run on every pull request on branches `main`, `feature/*` and `hotfix/*`. 

After that we have to define the jobs. In this case it will just be one that will reference the reusable workflow we've created previously. 

The way for referencing that reusable workflow is as follows:
`uses: {user}/{repository_name}/.github/workflows/{name_of_the_reusable_workflow}.yaml@{branch}`

After that you will have to pass on the `inputs` and `secrets` we've defined at the beginning of the reusable workflow and you're ready to go.

**NOTE**: It is recommended to run the pipelines on your hosted GitHub runners rather than github's runners so you keep your credentials out of the public GitHub Ubuntu runner.