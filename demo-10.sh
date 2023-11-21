#!/bin/bash

set -e

source ./demo-lib.sh

helm uninstall hello-world || true
helm install hello-world oci://registry-1.docker.io/bitnamicharts/nginx
demo_start

exe kubectl get po
exe helm upgrade hello-world oci://registry-1.docker.io/bitnamicharts/nginx  --set replicaCount=2
exe kubectl get po
exe helm ls
exe helm rollback hello-world
exe kubectl get po

demo_end


