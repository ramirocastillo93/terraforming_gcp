
# terraforming_gcp
This is a project when we will learn how to deploy a GKE cluster using Terraform and Terratest. We will use Terraform's best practices in order to achieve the best possible outcome out of this tutorial. 

## File tree
First of all, let's see how this folder is created.

```
ramirocastillo93/terraforming_gcp
├── LICENSE
├── README.md
└── gcp
    ├── deployment
    │   ├── dev.tfvars
    │   ├── main.tf
    │   ├── prod.tfvars
    │   ├── providers.tf
    │   ├── variables.tf
    │   └── version.tf
    └── modules
        ├── gke
        │   ├── main.tf
        │   ├── outputs.tf
        │   ├── variables.tf
        │   └── version.tf
        └── vpc
            ├── main.tf
            ├── outputs.tf
            ├── variables.tf
            └── version.tf
```

As you can see there is a main folder with two sub-folders inside. 

The "deployment" folder will have all the files to run with the variables for different environments. In this case, we have the dev.tfvars and the prod.tfvars files containing the variables needed to be deployed on a dev and prod environment respectively. 

The "modules" folder will have all the reusable files with the resources that we want to use in different environments.