# Infrastructure

This repository contains the base infrastructure required for provisioning resources on Azure.

## Prerequisite

 - Install Terraform v0.7.0-rc2
 - Install Autoenv
 - Create a Terraform application on Azure 

## Usage
 
 - Modify `.shared/secrets.sh` with your Azure credentials, see `.shared/secrets.sh.example`
 - Modify the defaults for variables within `.shared/variables.tf` `.shared/variables.sh` as you see fit
 - cd into `base-configuration`
     - ignore the remote state errors
     - execute `terraform apply`
     - execute `./.env`

## Results
 
 - Base Configuration
     - Resource Group
         - Storage Account
             - Storage Container: Machine Images
             - Storage Container: Terraform States
