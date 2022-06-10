#!/bin/sh

ansible-playbook --vault-password-file .vault_password -i inventory/ setup_server.yml $@
