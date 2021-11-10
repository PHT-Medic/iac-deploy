##----------------------------------------------------------
## Enable secrets engines
##----------------------------------------------------------
#
## Mount the default KV engines
#
#resource "vault_mount" "demo-stations" {
#  path = "demo-stations"
#  type = "kv-v2"
#}
#
#resource "vault_mount" "kv-pht-routes" {
#  path = "kv-pht-routes"
#  type = "kv-v2"
#}
#
#resource "vault_mount" "services" {
#  path = "services"
#  type = "kv-v1"
#}
#
#resource "vault_mount" "station_pks" {
#  path = "station_pks"
#  type = "kv-v1"
#}
#
#resource "vault_mount" "user_pks" {
#  path = "user_pks"
#  type = "kv-v1"
#}
#
## Enable Transit secrets engine at 'transit'
#resource "vault_mount" "transit" {
#  path = "transit"
#  type = "transit"
#}
#
## Creating an encryption key named 'payment'
#resource "vault_transit_secret_backend_key" "key" {
#  depends_on = [vault_mount.transit]
#  backend    = "transit"
#  name       = "payment"
#  deletion_allowed = true
#}
