# Allow renewal of leases for secrets
path "sys/renew/*" {
  policy = "write"
}

# Allow renewal of token leases
path "auth/token/renew/*" {
  policy = "write"
}

path "transit/encrypt/interview_onix_*" {
  policy = "write"
}

path "transit/decrypt/interview_onix_*" {
  policy = "write"
}