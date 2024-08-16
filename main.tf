
module "serviceauthcentral_kms_gcp" {
    # TODO: This should pull in a release version of the module, not just pull from main
    source           = "git::https://github.com/UnitVectorY-Labs/serviceauthcentral-kms-gcp-tofu.git?ref=main"
    name             = var.name
    project_id       = var.project_id
    kms_existing_key = var.kms_existing_key
}

module "crossfiresyncrun" {
    # TODO: This should pull in a release version of the module, not just pull from main
    source                    = "git::https://github.com/UnitVectorY-Labs/crossfiresyncrun-tofu.git?ref=main"
    name                      = var.name
    project_id                = var.project_id
    regions                   = var.regions
    firestore_deletion_policy = var.firestore_deletion_policy
}

module "serviceauthcentral_firestore_gcp" {
    for_each              = toset(var.regions)
    # TODO: This should pull in a release version of the module, not just pull from main
    source                = "git::https://github.com/UnitVectorY-Labs/serviceauthcentral-firestore-gcp-tofu.git?ref=main"
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
    # TODO: This should pull in a release version of the module, not just pull from main
    source          = "git::https://github.com/UnitVectorY-Labs/serviceauthcentral-token-gcp-tofu.git?ref=main"
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

    depends_on            = [ module.crossfiresyncrun ]
}

module "serviceauthcentral_manage_gcp" {
    # TODO: This should pull in a release version of the module, not just pull from main
    source           = "git::https://github.com/UnitVectorY-Labs/serviceauthcentral-manage-gcp-tofu.git?ref=main"
    name             = var.name
    project_id       = var.project_id
    regions          = var.regions
    region_db_names  = local.region_db_names
    sac_issuer       = var.sac_issuer
    sac_cors_origins = var.sac_cors_origins
    depends_on       = [ module.crossfiresyncrun ]
}