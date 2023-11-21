# Helm Demo

This is a Helm demo using Dev Containers.
It was created as part of the presentation "An introduction to Helm: A better way to manage your Kubernetes applications" at the [Cloud Native Computing Meetup | November 2023](https://www.meetup.com/cloud-native-computing-switzerland/events/291068669/)

## Setup

You can use DevContainer to run everything inside Docker without installing anything.
Start the DevContainer either within VS Code or with GitHub Codespaces.


* Use the Dev Containers in VS Code: Reopen in Container command from the Command Palette (`F1`, `Ctrl+Shift+P`).
* [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/Lazzaretti/helm-demo?quickstart=1)

## Simple nginx Helm chart

Let's deploy a simple nginx http server for [Bitnami](https://artifacthub.io/packages/helm/bitnami/nginx).

### 1. Install with cli

> You can also run this with the script `./demo-1.sh`

```sh
helm install hello-world oci://registry-1.docker.io/bitnamicharts/nginx
```

test it
```sh
kubectl port-forward svc/hello-world-nginx 8000:80
```

#### Step-by-step: What happened

Check what we have deployed:

1. Via the web page https://artifacthub.io/packages/helm/bitnami/nginx
2. Locally
   > you can also run this with the script `./demo-2.sh`
   1. Download and unpack the Helm chart
      `helm pull oci://registry-1.docker.io/bitnamicharts/nginx --untar --untardir out/`
   2. Inspect the out folder
      `tree out/ -L 3`
3. See how it looks after it is rendered
   > you can also run this with the script `./demo-3.sh`
   `helm template --output-dir './out' hello-world oci://registry-1.docker.io/bitnamicharts/nginx`
5. Release
   `helm install hello-world oci://registry-1.docker.io/bitnamicharts/nginx`
6. Check the release
   > you can also run this with the script `./demo-4.sh`
   `helm ls`


### 2. Upgrade & add parameters

> You can also run this with the script `./demo-10.sh`

```sh
kubectl get po
helm upgrade hello-world oci://registry-1.docker.io/bitnamicharts/nginx --set replicaCount=2
kubectl get po
helm ls
helm rollback hello-world
kubectl get po
```

### 2. Install with values from file

```sh
helm upgrade hello-world oci://registry-1.docker.io/bitnamicharts/nginx -f hello-world-values.yaml
```

### Show diff

```sh
helm plugin install https://github.com/databus23/helm-diff
helm diff upgrade hello-world oci://registry-1.docker.io/bitnamicharts/nginx -f hello-world-values.yaml
```

### Uninstall the chart

```sh
helm uninstall hello-world
```

## Use Helmfile

```sh
helmfile apply
```

## Helm with Terraform

(Make sure to uninstall the old chart first if you haven't done so already: `helm uninstall hello-world`)

```sh
terraform init
terraform apply
```

## Create an own chart

1. The creation of a chart has already been completed; you can achieve this by using `helm create mychart`
2. `helm install mychart mychart`
3. `helm ls`
4. `kubectl get configmap`
5. `kubectl get configmap mychart-config-map -o yaml`


