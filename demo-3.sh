#!/bin/bash

set -e

source ./demo-lib.sh

helm uninstall hello-world || true
rm -rf out
helm pull oci://registry-1.docker.io/bitnamicharts/nginx --untar --untardir out/

demo_start


exe helm template --output-dir './out' hello-world out/nginx/
exe head out/nginx/templates/deployment.yaml
exe helm install hello-world out/nginx/

demo_end


