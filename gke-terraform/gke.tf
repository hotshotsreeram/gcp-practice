resource "google_container_cluster" "my_cluster" {
  name     = var.name
  location = var.location
  node_pool {
    name       = "node-pool"
    initial_node_count = 1
    # Specify other node pool settings as needed
  }
}

