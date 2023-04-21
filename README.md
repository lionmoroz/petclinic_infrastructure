# petclinic_infrastructure

PetClinic Infrastructure

PetClinic Infrastructure is a project that creates and manages the infrastructure for a PetClinic application on Google Cloud Platform (GCP) using Ansible and Terraform. This repository contains the configuration files and code necessary to deploy the PetClinic application infrastructure on GCP.

Prerequisites
Before running the project, you need to ensure that the following are installed:

- Ansible
- Terraform
- GCP CLI
- A GCP account with billing enabled
- A GCP project created


Setting Up
1. Clone the repository to your local machine
2. Open petclinic_terraform foder: cd petclinic_infrustructure/petclinic_terraform
3. In this folder settings variable in file variables.tf
4. Run terraform init to initialize the Terraform backend and providers.
5. Run terraform apply to create the infrastructure on GCP.

6. Once the infrastructure is created, you can use Ansible to configure the PetClinic application.

7. Open petclinic_ansible folder.
8. Settings the host file.
9. Settings the prod_servers file in group_vars folder
10. Run the command: ansible-playbook palybook.yaml

Conclusion:

PetClinic Infrastructure is a project that makes it easy to create and manage the infrastructure for a PetClinic application on GCP using Ansible and Terraform. With this project, you can easily set up the necessary infrastructure for your PetClinic application and focus on developing your application.
