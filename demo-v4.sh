#!/bin/bash
set -e

source ./demo-lib.sh

helm uninstall hello-world || true

demo_start

exe helm install hello-world ./charts/demo-v4 -f ./charts/demo-v4/values.yaml --wait

sleep 0.1

kubectl port-forward svc/hello-world-demo-v4 8000:80 > /dev/null 2>&1 &
PORT_FORWARD_PID=$!
type kubectl port-forward svc/hello-world-demo-v4 8000:80
sleep 2

read -p "Port forwarding active, see http://localhost:8000/. Continue with enter..."

exe helm upgrade hello-world ./charts/demo-v4 -f ./charts/demo-v4/values.yaml -f ./charts/demo-v4/values.multi.yaml --wait

sleep 0.1

kill $PORT_FORWARD_PID 2>/dev/null

kubectl port-forward svc/hello-world-demo-v4 8000:80 > /dev/null 2>&1 &
PORT_FORWARD_PID=$!
type kubectl port-forward svc/hello-world-demo-v4 8000:80
sleep 2

read -p "Version updated, reload page. Close with enter..."
kill $PORT_FORWARD_PID 2>/dev/null
