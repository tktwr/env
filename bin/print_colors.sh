#!/bin/sh

f_print_colors()
{
  esc="\033["

  printf "Normal "
  for fg in 30 31 32 33 34 35 36 37; do
    esc_begin="${esc}${fg}m"
    esc_end="${esc}0m"
    printf "${esc_begin} Text ${esc_end} "
  done
  printf "\n"

  printf "Bold   "
  for fg in 30 31 32 33 34 35 36 37; do
    esc_begin="${esc}${fg};1m"
    esc_end="${esc}0m"
    printf "${esc_begin} Text ${esc_end} "
  done
  printf "\n"

  printf "\n"

  for fg in 30 31 32 33 34 35 36 37; do
    printf "       "
    for bg in 40 41 42 43 44 45 46 47; do
      esc_begin="${esc}${bg};${fg}m"
      esc_end="${esc}0m"
      printf "${esc_begin} Text ${esc_end} "
    done
    printf "\n"
  done
}

f_print_colors
