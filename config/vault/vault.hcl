backend "file" {
  path = "/opt/vault/secrets"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 0
  tls_cert_file = "/opt/vault/ca/certs/localhost.cert.pem"
  tls_key_file = "/opt/vault/ca/private/localhost.decrypted.key.pem"
  tls_min_version = "tls10"  
}

disable_mlock = true
ui = true
