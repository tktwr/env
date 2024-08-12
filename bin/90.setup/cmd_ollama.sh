#!/bin/bash

model='codellama'
pre_prompt='You are an expert programmer that writes simple, concise code and explanations.'

#------------------------------------------------------
f_ollama_run_gen_code() {
  ollama run $model '<PRE> def compute_gcd(x, y): <SUF>return result <MID>'
}
f_ollama_run_gen_git_commit_message() {
  prompt="Write a one-line git commit message that summarizes the following diff output: $(git diff)"
  echo "$pre_prompt $prompt"
  ollama run $model "$pre_prompt $prompt"
}
