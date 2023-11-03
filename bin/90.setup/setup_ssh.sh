#!/bin/bash

#======================================================
# variables
#======================================================
EMAIL="your_email@example.com"
KEY_TYPE=ed25519

#======================================================
# functions
#======================================================
f_ssh_agent_start() {
  ssh-agent $SHELL
}

f_ssh_agent_stop() {
  ssh-agent -k
}

f_ssh_key_gen() {
  ssh-keygen -t $KEY_TYPE -C "$EMAIL"
}

f_ssh_key_add() {
  ssh-add
}

f_ssh_key_list() {
  ssh-add -l
}

f_ssh_key_info() {
  ssh-keygen -l -f ~/.ssh/id_$KEY_TYPE.pub
}

f_ssh_key_chpass() {
  ssh-keygen -p -f ~/.ssh/id_$KEY_TYPE
}

#======================================================
# main
#======================================================
f_fzf_main "$@"
