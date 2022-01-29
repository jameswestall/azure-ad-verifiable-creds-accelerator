# Wellknown container

This container is designed to simplify hosting of the wellknown files for domain verification. 
Microsoft describes this process [at this link.](https://docs.microsoft.com/en-us/azure/active-directory/verifiable-credentials/how-to-dnsbind)

**ASSUMPTION:** The action associated with this folder assumes that you have deployed an Azure Container Registry as defined in the [terraform](/terraform) folder. 

### Usage
To use this container, complete the following steps:

1. Download the wellknown did-configuration file from the Azure Portal, replacing the contents located at [./public/.well-known/did-configuration.json](./public/.well-known/did-configuration.json)

2. Within the DNS Zone which you control, add a CNAME which will be used for the ACI that is deployed. ACI names should be unique, make the name meaningful to you. ACI FQDN are region specific `containername.region.azurecontainer.io`

    ![wellknown-dns-zone](/media/wellknown-dns-zone.png)

3. Update the global.env file properties required for this container

    ```
    wellknown_container_name=vc-wellknown # should match the name specified in step 2
    wellknown_container_version=0.2 # lets you version container types
    wellknown_cname=vc.demo.arinco.com.au # the domain you are verifying
    ```

4. Commit your changes. Provided that you have already configured the appropriate environment variables as per the [central readme](/readme.md), the container should automatically deploy to azure. 

5. Verify the deployed ACI. Logs after 3 minutes should look like so. 

    ![wellknown-working-container](/media/wellknown-working-container.png)

### General Notes

- Letsencrypt has a rate limit of 5 issued certificates within a 168 hour period. When troubleshooting, you may hit this limit if you're continually redeploying containers. This can be worked around by editing the [run.sh](./run.sh) file with an extra domain `-d did.domain.com` and adding the appropriate DNS records.

