provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "hello-world" {
  name    = "hello-world"
  chart   = "oci://registry-1.docker.io/bitnamicharts/nginx"
  version = "15.4.2"
  set {
    name  = "replicaCount"
    value = "2"
  }
  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}