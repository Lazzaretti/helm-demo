#!/bin/bash
set -e

source ./demo-lib.sh

helm uninstall live-v4 || true

demo_start

exe helm install live-v4 ./charts/demo-v4 -f ./charts/demo-v4/values.yaml

sleep 0.1

exe kubectl rollout status deployment live-v4-demo-v4 --timeout=90s

kubectl port-forward svc/live-v4-demo-v4 8000:80 > /dev/null 2>&1 &
PORT_FORWARD_PID=$!
type kubectl port-forward svc/live-v4-demo-v4 8000:80
sleep 2

read -p "Port forwarding active, see http://localhost:8000/. Continue with enter..."

exe helm upgrade live-v4 ./charts/demo-v4 -f ./charts/demo-v4/values.yaml -f ./charts/demo-v4/values.multi.yaml

sleep 0.1

exe kubectl rollout status deployment live-v4-demo-v4 --timeout=90s

kill $PORT_FORWARD_PID 2>/dev/null

kubectl port-forward svc/live-v4-demo-v4 8000:80 > /dev/null 2>&1 &
PORT_FORWARD_PID=$!
type kubectl port-forward svc/live-v4-demo-v4 8000:80
sleep 2

read -p "Version updated, reload page. Close with enter..."
kill $PORT_FORWARD_PID 2>/dev/null
