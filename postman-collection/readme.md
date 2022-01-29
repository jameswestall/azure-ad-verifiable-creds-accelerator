# Verifiable Credentials Request API - Postman Collection

The postman collection in this folder shows the most basic usage of the Azure AD Verifiable Credentials API. 

Full Microsoft documentation is available [here for issuance](https://docs.microsoft.com/en-us/azure/active-directory/verifiable-credentials/issuance-request-api) and [here for presentation](https://docs.microsoft.com/en-us/azure/active-directory/verifiable-credentials/presentation-request-api). 


Using this postman collection requires your tenant to already be configured for Azure AD Verifiable Credentials, [as per this documentation.](https://docs.microsoft.com/en-us/azure/active-directory/verifiable-credentials/verifiable-credentials-configure-tenant)



### Setting up Azure AD Application Registration
In order to use this collection, an Azure AD Application registration is required. To create this registration, the following steps are required. 

1. Navigate to the [Azure Active Directory Portal](https://aad.portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview), select App Registrations
2. Select New Registration
3. Provide a name which is meaningful to you: `vc-postman-demo`
4. Select Web, under Redirect URI, providing the following URL: `https://oauth.pstmn.io/v1/callback`

    ![postman-create-app-registration](/media/postman-create-app-registration.png)

5. Once created, add a client secret with an appropriate expiry window.

    ![postman-client-secret](/media/postman-client-secret.png)

6. Under API Permissions, select Add a Permission, The Verifiable Credentials Request Service shows up under API's my organization uses. Add the "VerifiableCredential.Create.All" permission. 

    ![postman-permissions](/media/postman-permissions.png)

7. Grant admin consent for your Azure AD tenant. 

    ![postman-permissions-granted](/media/postman-permissions-granted.png)

8. Finally, Note down the following details:
    - Tenant ID
    - Client ID
    - Client Secret

Full detail on [service principal requirements can be found here.](https://docs.microsoft.com/en-us/azure/active-directory/verifiable-credentials/verifiable-credentials-configure-tenant#grant-permissions-to-get-access-tokens)

### Configuring your Postman Environment
Once you have a configured application registration, the following details need to be set within the Postman environment. 

|Variable|Description|Where to Obtain|
|--------|-----------|---------------|
|tenantid|The GUID for your AzureAD Tenant|Azure AD Portal or App Registrations Blade|
|clientid|The GUID for your AzureAD Application Registration|App Registrations Blade|
|clientid|The Client Secret for your AzureAD Application Registration|App Registrations Blade|
|didauthority|The DID which you will be requesting or verifying credentials with|Azure AD Portal > Security > Verifiable Credentials|
|didmanifest|The manifest of the Verifiable Credential which you will be requesting |Azure AD Portal > Security > Verifiable Credentials > Configured VC|
|vctype|The Short name of the Verifiable Credential which you will be issuing or validating|Azure AD Portal > Security > Verifiable Credentials > Configured VC|
|clientname|What you would like to identify your calls as|N/A - Set to a default, change if required|
|requiredscope|Scope required when requesting an access token, [as per this documentation](https://docs.microsoft.com/en-us/azure/active-directory/verifiable-credentials/verifiable-credentials-configure-tenant#grant-permissions-to-get-access-tokens)| N/A, requires no update. Currently set to `bbb94529-53a3-4be5-a069-7eaf2712b826/.default`|



### Useful Notes
An excellent demonstration of the [VC API is available here.](https://www.youtube.com/watch?v=97V9_MoMwEs).

The Postman collection includes a test snippet to show QR codes without leaving the Postman Client. Credit to Rohit Gulati and Matthjis Hoekstra for showing me this in the aforementioned VC API demo. 

```javascript
let template = `
<img src='{{img}}'/>
`;
pm.visualizer.set(template, {
    img: pm.response.json()["qrCode"]
});
```