#!/bin/bash

#======================================================
# variables
#======================================================
SSH_EMAIL="your_email@example.com"
SSH_KEY_TYPE=ed25519

#======================================================
# functions
#======================================================
f_ssh_key_gen()         { ssh-keygen -t $SSH_KEY_TYPE -C "$SSH_EMAIL"  ; }
f_ssh_key_info()        { ssh-keygen -l -f ~/.ssh/id_$SSH_KEY_TYPE.pub ; }
f_ssh_key_chpass()      { ssh-keygen -p -f ~/.ssh/id_$SSH_KEY_TYPE     ; }
f_ssh_agent_start()     { ssh-agent $SHELL                             ; }
f_ssh_agent_stop()      { ssh-agent -k                                 ; }
f_ssh_agent_add_key()   { ssh-add                                      ; }
f_ssh_agent_list_keys() { ssh-add -l                                   ; }
