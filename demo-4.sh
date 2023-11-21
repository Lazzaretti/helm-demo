#!/bin/bash

set -e

source ./demo-lib.sh

demo_start

exe kubectl get service
exe kubectl get deployments.app
exe kubectl get pod
exe helm ls

demo_end


