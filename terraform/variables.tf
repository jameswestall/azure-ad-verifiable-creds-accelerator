variable "subscription_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "tenant_id" {
  type = string
}

variable "default_location" {
  type    = string
  default = "australiaeast"
}

variable "admin_object_id" {
  type = string
}

variable "resource_groups" {
  type = map(object({
    name = string
    tags = map(string)
  }))
  description = "Resource groups to be deployed by terraform"
  default = {
    vc-shared-rgp = {
      name = "prd-vc-aad-rgp"
      tags = {
        "owner"       = "Festive "
        "environment" = "prd"
        "service"     = "verifiable credentials - azure ad"
      }
    },
    vc-demo-issuer-rgp = {
      name = "prd-vc-issuer-rgp"
      tags = {
        "owner"       = "arinco australia"
        "environment" = "prd"
        "service"     = "verifiable credentials - issuer"
      }
    },
    vc-demo-verifier-rgp = {
      name = "prd-vc-verifier-rgp"
      tags = {
        "owner"       = "arinco australia"
        "environment" = "prd"
        "service"     = "verifiable credentials - verifier"
      }
    }
  }
}

variable "keyvault_name" {
  type        = string
  description = "keyvault name to be used for azure ad verifiable credentials"
  default     = "festive-vc-aad-kvt"
}

variable "acr_name" {
  type        = string
  description = "acr to be used for azure ad verifiable credentials demo websites"
  default     = "festiveaadvcacr"
}

variable "storage_name" {
  type        = string
  description = "storage account to be used for azure ad verifiable credentials"
  default     = "festiveaadvcstg"
}

variable "storage_containers" {
  type        = map(string)
  description = "containers within the aad VC storage"
  default = {
    vc-display = "vc-display-files"
    vc-rules   = "vc-rule-files"
    general    = "vc-general-files"
  }
}