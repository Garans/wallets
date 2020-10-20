require "vault/rails"

Vault::Rails.configure do |vault|
  # Use Vault in transit mode for encrypting and decrypting data. If
  # disabled, vault-rails will encrypt data in-memory using a similar
  # algorithm to Vault. The in-memory store uses a predictable encryption
  # which is great for development and test, but should _never_ be used in
  # production. Default: ENV["VAULT_RAILS_ENABLED"].
  vault.enabled = Rails.env.production? || Rails.env.development?

  # The name of the application. All encrypted keys in Vault will be
  # prefixed with this application name. If you change the name of the
  # application, you will need to migrate the encrypted data to the new
  # key namespace. Default: ENV["VAULT_RAILS_APPLICATION"].
  vault.application = "interview_onix"

  # The address of the Vault server. Default: ENV["VAULT_ADDR"].
  vault.address = ENV.fetch('VAULT_ADDR', 'http://127.0.0.1:8200')
  vault.ssl_verify = false
  # The token to communicate with the Vault server.
  # Default: ENV["VAULT_TOKEN"].
  vault.token = "s.aP3OOOX5wvdCPiUIIz5jV2Un"
end