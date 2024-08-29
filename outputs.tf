
output "token_region_service_map" {
  value = module.serviceauthcentral_token_gcp.region_service_map
}

output "manage_region_service_map" {
  value = module.serviceauthcentral_manage_gcp.region_service_map
}