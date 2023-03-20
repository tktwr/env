#!/bin/bash

ESC="\033["

f_line() {
  attr=$1
  for fg in 30 31 32 33 34 35 36 37; do
    begin="${ESC}${attr};${fg}m"
    end="${ESC}0m"
    printf "${begin} Text ${end} "
  done
  printf "\n"
}

f_print_colors() {
  printf "Normal "
  f_line 0
  printf "Bold   "
  f_line 1
  printf "Under  "
  f_line 4
  printf "Blink  "
  f_line 5
  printf "Rev    "
  f_line 7


  printf "\n"

  for fg in 30 31 32 33 34 35 36 37; do
    printf "       "
    for bg in 40 41 42 43 44 45 46 47; do
      begin="${ESC}${bg};${fg}m"
      end="${ESC}0m"
      printf "${begin} Text ${end} "
    done
    printf "\n"
  done
}

f_print_colors
