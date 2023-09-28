resource "kubernetes_namespace" "my_namespace" {
  metadata {
    name = var.namespace_name
  }
}

resource "helm_release" "my_app" {
  name       = var.release_name
  namespace  = kubernetes_namespace.my_namespace.metadata[0].name
  repository = "https://raw.githubusercontent.com/hotshotsreeram/gcp-practice/gh-pages/"
  chart      = var.chart
  version    = var.helm_chart_version

  values     = [ file("/var/lib/jenkins/workspace/helm-terraform/my-parent-chart/values.yaml") ] 
}