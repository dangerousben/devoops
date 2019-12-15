#!/bin/sh

ansible-playbook --ask-vault-pass -i inventory/ setup_server.yml
