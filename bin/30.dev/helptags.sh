#!/bin/bash

f_helptags() {
  vim -e -c 'helptags . | quit'
}

f_helptags
