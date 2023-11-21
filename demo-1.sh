#!/bin/bash

set -e
type(){
    s=$@
    for ((i=0; i<${#s} ; i++)) ; do 
        echo -n "${s:i:1}"
        sleep 0.05
    done
    echo 
}

pause() { sleep 0.1; }
exe() { type "\$ $@" ; pause; "$@" ; pause; }


helm uninstall hello-world || true
clear
sleep 0.1

exe helm install hello-world oci://registry-1.docker.io/bitnamicharts/nginx

sleep 0.1

exe kubectl rollout status deployment hello-world-nginx --timeout=90s

exe kubectl port-forward svc/hello-world-nginx 8000:80

read wait
