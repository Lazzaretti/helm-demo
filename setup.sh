#!/bin/bash

set -e

minikube start
minikube addons enable ingress
nohup kubectl port-forward --pod-running-timeout=24h -n ingress-nginx service/ingress-nginx-controller :80 &

# dependencies

## helm diff
helm plugin install https://github.com/databus23/helm-diff

## helmfile
(
cd /tmp
wget https://github.com/helmfile/helmfile/releases/download/v0.158.1/helmfile_0.158.1_linux_amd64.tar.gz
tar -xzvf /tmp/helmfile_0.158.1_linux_amd64.tar.gz
sudo cp helmfile /usr/local/bin/
)

## terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
