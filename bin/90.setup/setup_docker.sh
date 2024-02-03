#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_docker_img_pull()   { docker image pull         ; }
f_docker_img_ls()     { docker image ls           ; }
f_docker_img_rm()     { docker image rm           ; }
f_docker_cnt_ls()     { docker container ls       ; }
f_docker_cnt_ls_all() { docker container ls --all ; }
f_docker_cnt_rm()     { docker container rm       ; }
f_docker_cnt_commit() { docker container commit   ; }
f_docker_cnt_run()    { docker container run      ; }
f_docker_cnt_start()  { docker container start    ; }
f_docker_cnt_stop()   { docker container stop     ; }

f_docker_cnt_restart() {
  docker container start
  docker container attach
}

