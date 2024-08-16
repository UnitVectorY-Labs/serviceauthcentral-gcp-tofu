variable "name" {
  description = "The name of the application"
  type        = string
  default     = "serviceauthcentral"

  validation {
    condition     = can(regex("^[a-z](?:[-a-z0-9]{1,21}[a-z0-9])$", var.name))
    error_message = "The name must start with a lowercase letter and can contain lowercase letters, numbers, and hyphens. It must be between 2 and 22 characters long."
  }
}

variable "project_id" {
  description = "The GCP project id"
  type        = string
}

variable "kms_existing_key" {
  description = "Boolean value indicating if an existing KMS key should be used"
  type        = bool
  default     = false
}

variable "regions" {
  description = "List of regions where resources will be created"
  type        = list(string)
}

variable "firestore_deletion_policy" {
  description = "The deletion policy for Firestore databases"
  type        = string
  default     = "ABANDON"

  validation {
    condition     = contains(["ABANDON", "DELETE"], var.firestore_deletion_policy)
    error_message = "The firestore_deletion_policy variable must be one of: ABANDON, DELETE."
  }
}

variable "sac_issuer" {
  description = "The SAC_ISSUER envirionment variable specifying the issuer"
  type        = string
}

variable "sac_cors_origins" {
  description = "The SAC_CORS_ORIGINS envirionment variable specifying the allowed origins"
  type        = string
}

variable "sac_user_redirecturi" {
  description = "The SAC_USER_REDIRECTURI envirionment variable specifying the redirect uri"
  type        = string
}

variable "sac_user_provider_github_clientid" {
  description = "The SAC_USER_PROVIDER_GITHUB_CLIENTID envirionment variable specifying the GitHub client id"
  type        = string
}

variable "sac_user_provider_github_clientsecret" {
  description = "The SAC_USER_PROVIDER_GITHUB_CLIENTSECRET envirionment variable specifying the GitHub client secret"
  type        = string
  sensitive   = true
}
