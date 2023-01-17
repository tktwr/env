#!/bin/bash

apt_list_filter() {
  cut -d '/' -f 1
}

pkg=$(echo "$*" | apt_list_filter)
apt show $pkg 2> /dev/null
