# README

This README would normally document whatever steps are necessary to get the
application up and running.

### Web frontend
web fronted part: http://ec2-34-219-186-41.us-west-2.compute.amazonaws.com

### Basic requirements

This project includes two databases on the different container,
first DB main save wallets, users, transactions data, in second DB saving pin codes for a wallet

#### Vault
This project require vault secret storage https://www.vaultproject.io/

vault install document https://www.vaultproject.io/docs/install

#### Docker

Install docker guide https://docs.docker.com/desktop/

#### Docker Compose

Install guide https://docs.docker.com/compose/install/

### Run server
#### Automate
```bash
./run.sh
```

#### Manual
```bash
vault server --dev
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN="past token from message command vault server -dev"
vault_server vault secrets enable transit
vault_server vault secrets enable -version=2 kv
rails db:create && rails crypted:db:create
rails db:migrate && rails crypted:db:migrate
rails db:seed
rails population:generate_wallet_list
rails s
```