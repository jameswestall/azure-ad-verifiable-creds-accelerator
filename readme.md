# Azure AD Verifiable Credentials - Adoption Accelerator

This repository holds code and content that is designed to help you adopt verifiable credentials quicker. Content has been developed AND collected from Microsoft official samples.
Most of this repo is configured to work with GitHub Actions, provided appropriate repo secrets have been set. 

- [terraform](/terraform/) holds definitions for required resources when setting up your tenant for verifiable credentials. 
- [src-node-deprecated](/src-node-deprecated/) is an example using the *deprecated* Verifiable Credentials API (As of 21 December 2021 this was functioning, expect it to break in future).
- [vcdisplay](/vcdisplay/), [vcimages](/vcimages/) & [vcrules](/vcrules/) contain samples of VC Rule and Display Files. These folders are automatically uploaded to Azure Storage accounts by a GitHub Action, enabling usage by the Verifiable Credentials Service. 
- [postman-collection](/postman-collection/) details how to request a verifiable credential without writing a single line of code (testing scenarios)
- [wellknown](/wellknown/) is a simple (not-production ready) ACI hosted container which can be used for verifying your selected domain. 

### Forking this respository
This repo is setup to use GitHub Actions to simplify deployment. The following steps will help you get started

1. Fork this repository into your account
2. You will need to enable Actions in this repository. Go to `Actions` tab and click on `I understand my workflows, go ahead and enabled them` button.
3. Even though each workflow exists, you will need to approve it for your repo. On the next screen, select each workflow.
4. You should see `This scheduled workflow is disabled because scheduled workflows are disabled by default in forks.` warning. Click on `Enable workflow` button next to it.
5. Create an Azure Storage Account to store Terraform State within. 
6. Configure the following secrets for your environment
    - AZURE_LOGIN_SECRET -> output from `az ad sp create-for-rbac --sdk-auth`
    - AZURE_SERVICE_PRINCIPAL_CLIENT_ID -> Client ID from above
    - AZURE_SERVICE_PRINCIPAL_CLIENT_SECRET -> Client Secret from above
    - AZURE_SERVICE_PRINCIPAL_TENANT_ID -> Tenant ID from above
    - AZURE_SERVICE_PRINCIPAL_SUBSCRIPTION_ID -> Azure Subscription from above
    - ARM_ACCESS_KEY -> Key to use an Azure Storage Account for Terrafrom State. As per setup instructions from [Microsoft]()
    - ADMIN_EMAIL -> Email to receive lets encrypt notifications. This is a secret to prevent scraping on any public hosted repos :)
7. With the appropriate secrets and environment variables configured, you can now run each github action to deploy Verifiable credentials resources. Each action may have further required setup tasks, please refer to the table below for details. 

### Note - This repo is a work in process and will be added to over time. 
