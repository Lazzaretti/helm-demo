#!/bin/bash

set -e

source ./demo-lib.sh

rm -rf out
demo_start

exe helm pull oci://registry-1.docker.io/bitnamicharts/nginx --untar --untardir out/

exe tree out/ -L 3
exe head out/nginx/templates/deployment.yaml 

demo_end


