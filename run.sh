#!/usr/bin/env bash

docker-compose up -d vault_server
sleep 5
docker-compose exec vault_server vault secrets enable transit
docker-compose exec vault_server vault secrets enable -version=2 kv

docker-compose up -d

#& && vault secrets enable transit && vault secrets enable -version=2 kv && tail -f /dev/null
