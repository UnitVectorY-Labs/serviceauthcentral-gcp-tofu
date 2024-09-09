[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![Work In Progress](https://img.shields.io/badge/Status-Work%20In%20Progress-yellow)](https://unitvectory-labs.github.io/uvy-labs-guide/bestpractices/status/#work-in-progress)

# serviceauthcentral-gcp-tofu

OpenTofu module for deploying a fully working ServiceAuthCentral deployment in GCP

## References

- [ServiceAuthCentral](https://github.com/UnitVectorY-Labs/ServiceAuthCentral) - Simplify microservice security with ServiceAuthCentral: Centralized, open-source authorization in the cloud, minus the shared secrets.
- [ServiceAuthCentral Documentation](https://unitvectory-labs.github.io/ServiceAuthCentral/) - Documentation for ServiceAuthCentral
- [serviceauthcentralweb](https://github.com/UnitVectorY-Labs/serviceauthcentralweb) - Web based management interface for ServiceCloudAuth
- [serviceauthcentral-client-java](https://github.com/UnitVectorY-Labs/serviceauthcentral-client-java) - Java client for requesting tokens from the ServiceAuthCentral OAuth 2.0 authorization server.
- [serviceauthcentral-gcp-tofu](https://github.com/UnitVectorY-Labs/serviceauthcentral-gcp-tofu) - OpenTofu module for deploying a fully working ServiceAuthCentral deployment in GCP

### Tofu Modules

- [serviceauthcentral-token-gcp-tofu](https://github.com/UnitVectorY-Labs/serviceauthcentral-token-gcp-tofu) - OpenTofu module for deploying ServiceAuthCentral token API to Cloud Run in GCP
- [serviceauthcentral-manage-gcp-tofu](https://github.com/UnitVectorY-Labs/serviceauthcentral-manage-gcp-tofu) - OpenTofu module for deploying ServiceAuthCentral manage API to Cloud Run in GCP
- [serviceauthcentral-kms-gcp-tofu](https://github.com/UnitVectorY-Labs/serviceauthcentral-kms-gcp-tofu) - OpenTofu module for deploying ServiceAuthCentral KMS Keys in GCP
- [serviceauthcentral-firestore-gcp-tofu](https://github.com/UnitVectorY-Labs/serviceauthcentral-firestore-gcp-tofu) - OpenTofu module for deploying ServiceAuthCentral Firestore Database
- [serviceauthcentral-firestore-bootstrap-gcp-tofu](https://github.com/UnitVectorY-Labs/serviceauthcentral-firestore-bootstrap-gcp-tofu) - OpenTofu module for deploying ServiceAuthCentral Firestore records needed to bootstrap an install
- [serviceauthcentral-workload-identity-gcp-tofu](https://github.com/UnitVectorY-Labs/serviceauthcentral-workload-identity-gcp-tofu) - OpenTofu module for deploying ServiceAuthCentral Workload Identity Federation in GCP

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_crossfiresyncrun"></a> [crossfiresyncrun](#module\_crossfiresyncrun) | ./crossfiresyncrun-tofu | n/a |
| <a name="module_serviceauthcentral_firestore_bootstrap_gcp"></a> [serviceauthcentral\_firestore\_bootstrap\_gcp](#module\_serviceauthcentral\_firestore\_bootstrap\_gcp) | ./serviceauthcentral-firestore-bootstrap-gcp-tofu | n/a |
| <a name="module_serviceauthcentral_firestore_gcp"></a> [serviceauthcentral\_firestore\_gcp](#module\_serviceauthcentral\_firestore\_gcp) | ./serviceauthcentral-firestore-gcp-tofu | n/a |
| <a name="module_serviceauthcentral_kms_gcp"></a> [serviceauthcentral\_kms\_gcp](#module\_serviceauthcentral\_kms\_gcp) | ./serviceauthcentral-kms-gcp-tofu | n/a |
| <a name="module_serviceauthcentral_manage_gcp"></a> [serviceauthcentral\_manage\_gcp](#module\_serviceauthcentral\_manage\_gcp) | ./serviceauthcentral-manage-gcp-tofu | n/a |
| <a name="module_serviceauthcentral_token_gcp"></a> [serviceauthcentral\_token\_gcp](#module\_serviceauthcentral\_token\_gcp) | ./serviceauthcentral-token-gcp-tofu | n/a |
| <a name="module_serviceauthcentral_workload_identity_gcp"></a> [serviceauthcentral\_workload\_identity\_gcp](#module\_serviceauthcentral\_workload\_identity\_gcp) | ./serviceauthcentral-workload-identity-gcp-tofu | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifact_registry_host"></a> [artifact\_registry\_host](#input\_artifact\_registry\_host) | The name of the Artifact Registry repository | `string` | `"us-docker.pkg.dev"` | no |
| <a name="input_artifact_registry_name"></a> [artifact\_registry\_name](#input\_artifact\_registry\_name) | The name of the Artifact Registry repository | `string` | n/a | yes |
| <a name="input_artifact_registry_project_id"></a> [artifact\_registry\_project\_id](#input\_artifact\_registry\_project\_id) | The project to use for Artifact Registry. Will default to the project\_id if not set. | `string` | `null` | no |
| <a name="input_crossfiresyncrun_tag"></a> [crossfiresyncrun\_tag](#input\_crossfiresyncrun\_tag) | The tag for the crossfiresyncrun image to deploy | `string` | `"dev"` | no |
| <a name="input_firestore_deletion_policy"></a> [firestore\_deletion\_policy](#input\_firestore\_deletion\_policy) | The deletion policy for Firestore databases | `string` | `"ABANDON"` | no |
| <a name="input_kms_existing_key"></a> [kms\_existing\_key](#input\_kms\_existing\_key) | Boolean value indicating if an existing KMS key should be used | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the application | `string` | `"serviceauthcentral"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project id | `string` | n/a | yes |
| <a name="input_regions"></a> [regions](#input\_regions) | List of regions where resources will be created | `list(string)` | n/a | yes |
| <a name="input_sac_authorized_admin_user_clientid"></a> [sac\_authorized\_admin\_user\_clientid](#input\_sac\_authorized\_admin\_user\_clientid) | The client id of the initial admin user | `string` | n/a | yes |
| <a name="input_sac_cors_origins"></a> [sac\_cors\_origins](#input\_sac\_cors\_origins) | The SAC\_CORS\_ORIGINS envirionment variable specifying the allowed origins | `string` | n/a | yes |
| <a name="input_sac_issuer"></a> [sac\_issuer](#input\_sac\_issuer) | The SAC\_ISSUER envirionment variable specifying the issuer | `string` | n/a | yes |
| <a name="input_sac_user_provider_github_clientid"></a> [sac\_user\_provider\_github\_clientid](#input\_sac\_user\_provider\_github\_clientid) | The SAC\_USER\_PROVIDER\_GITHUB\_CLIENTID envirionment variable specifying the GitHub client id | `string` | n/a | yes |
| <a name="input_sac_user_provider_github_clientsecret"></a> [sac\_user\_provider\_github\_clientsecret](#input\_sac\_user\_provider\_github\_clientsecret) | The SAC\_USER\_PROVIDER\_GITHUB\_CLIENTSECRET envirionment variable specifying the GitHub client secret | `string` | n/a | yes |
| <a name="input_sac_user_redirecturi"></a> [sac\_user\_redirecturi](#input\_sac\_user\_redirecturi) | The SAC\_USER\_REDIRECTURI envirionment variable specifying the redirect uri | `string` | n/a | yes |
| <a name="input_serviceauthcentral_manage_tag"></a> [serviceauthcentral\_manage\_tag](#input\_serviceauthcentral\_manage\_tag) | The tag for the serviceauthcentral manage image to deploy | `string` | `"dev"` | no |
| <a name="input_serviceauthcentral_token_tag"></a> [serviceauthcentral\_token\_tag](#input\_serviceauthcentral\_token\_tag) | The tag for the serviceauthcentral token image to deploy | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_manage_region_service_map"></a> [manage\_region\_service\_map](#output\_manage\_region\_service\_map) | n/a |
| <a name="output_token_region_service_map"></a> [token\_region\_service\_map](#output\_token\_region\_service\_map) | n/a |
<!-- END_TF_DOCS -->
