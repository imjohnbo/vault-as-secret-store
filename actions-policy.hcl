# Read-only permission on 'secret/data/docker/*' path
path "secret/data/docker/*" {
  capabilities = [ "read" ]
}