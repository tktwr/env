#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_ollama_install() {
  curl https://ollama.ai/install.sh | sh
}

f_ollama_start() { sudo service ollama start; }
f_ollama_stop()  { sudo service ollama stop; }

f_ollama_info() {
  service ollama status
  ollama list
}

f_ollama_create() {
  #ollama create jp-stablelm-3b-inst -f Modelfile
  #ollama create jp-stablelm-7b-gamma-inst -f Modelfile
  ollama create elyza-jp-llama2-7b-fast-inst -f Modelfile
}
#------------------------------------------------------
# 3B                                 {                                         ; }
f_ollama_chat_phi()                  { ollama run phi                          ; }
f_ollama_chat_stablelm2()            { ollama run stablelm2                    ; }
f_ollama_chat_stablecode()           { ollama run stable-code                  ; }
f_ollama_chat_jp_stablelm_3b()       { ollama run jp-stablelm-3b-inst          ; }
# 7B                                 {                                         ; }
f_ollama_chat_codellama()            { ollama run codellama                    ; }
f_ollama_chat_mistral()              { ollama run mistral                      ; }
f_ollama_chat_jp_stablelm_7b_gamma() { ollama run jp-stablelm-7b-gamma-inst    ; }
f_ollama_chat_elyza_jp_7b()          { ollama run elyza-jp-llama2-7b-fast-inst ; }
# 30B                                {                                         ; }
f_ollama_chat_mixtral()              { ollama run mixtral                      ; }
