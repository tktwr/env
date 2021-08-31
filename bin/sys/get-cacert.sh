#!/bin/bash

curl -O https://curl.se/ca/cacert.pem
curl -O https://curl.se/ca/cacert.pem.sha256
sha256sum -c cacert.pem.sha256

