
module "serviceauthcentral_kms_gcp" {
    source           = "./serviceauthcentral-kms-gcp-tofu"
    name             = var.name
    project_id       = var.project_id
    kms_existing_key = var.kms_existing_key
}

module "crossfiresyncrun" {
    source                       = "./crossfiresyncrun-tofu"
    name                         = var.name
    project_id                   = var.project_id
    regions                      = var.regions
    firestore_deletion_policy    = var.firestore_deletion_policy
    artifact_registry_host       = var.artifact_registry_host
    artifact_registry_name       = var.artifact_registry_name
    artifact_registry_project_id = var.artifact_registry_project_id
    crossfiresyncrun_tag         = var.crossfiresyncrun_tag
    
}

module "serviceauthcentral_firestore_gcp" {
    for_each              = toset(var.regions)
    source                = "./serviceauthcentral-firestore-gcp-tofu"
    database_name         = "${var.name}-${each.value}"
    project_id            = var.project_id
    region                = each.value
    use_existing_database = true
    depends_on            = [ module.crossfiresyncrun ]
}

locals {
  region_db_names = { for region in var.regions : region => "${var.name}-${region}" }
}

module "serviceauthcentral_token_gcp" {
    source          = "./serviceauthcentral-token-gcp-tofu"
    name            = var.name
    project_id      = var.project_id
    regions         = var.regions
    region_db_names = local.region_db_names
    key_ring_name   = module.serviceauthcentral_kms_gcp.key_ring_name
    sign_key_name   = module.serviceauthcentral_kms_gcp.key_name

    # The configuration
    sac_issuer = var.sac_issuer
    sac_cors_origins = var.sac_cors_origins
    sac_user_redirecturi = var.sac_user_redirecturi
    sac_user_provider_github_clientid = var.sac_user_provider_github_clientid
    sac_user_provider_github_clientsecret = var.sac_user_provider_github_clientsecret

    artifact_registry_host       = var.artifact_registry_host
    artifact_registry_name       = var.artifact_registry_name
    artifact_registry_project_id = var.artifact_registry_project_id
    serviceauthcentral_token_tag = var.serviceauthcentral_token_tag

    depends_on            = [ module.crossfiresyncrun ]
}

module "serviceauthcentral_manage_gcp" {
    source           = "./serviceauthcentral-manage-gcp-tofu"
    name             = var.name
    project_id       = var.project_id
    regions          = var.regions
    region_db_names  = local.region_db_names

    sac_issuer       = var.sac_issuer
    sac_cors_origins = var.sac_cors_origins

    artifact_registry_host        = var.artifact_registry_host
    artifact_registry_name        = var.artifact_registry_name
    artifact_registry_project_id  = var.artifact_registry_project_id
    serviceauthcentral_manage_tag = var.serviceauthcentral_manage_tag

    depends_on       = [ module.crossfiresyncrun ]
}