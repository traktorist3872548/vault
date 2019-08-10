backend "file" {
  path = "/opt/vault/secrets"
}

listener "tcp" {
  address = "localhost:8200"
  tls_disable = 0
  ca_cert = "/opt/vault/ca/certs/ca.cert.pem"
  ca_path = "/opt/vault/ca/certs/ca.cert.pem"
  tls_cert_file = "/opt/vault/ca/certs/localhost.cert.pem"
  tls_key_file = "/opt/vault/ca/private/localhost.decrypted.key.pem"
  tls_min_version = "tls10"  
}

api_addr = "http://localhost:8200"
disable_mlock = true
ui = true
