resource "google_container_cluster" "my_cluster" {
  name     = var.name
  location = var.location
  node_pool {
    name       = "my-node-pool"
    initial_node_count = 1
    # Specify other node pool settings as needed
    node_config {
      machine_type = "n1-standard-2"  # Specify the machine type (e.g., n1-standard-2)
      disk_size_gb = 20  # Allocate 20GB of storage for each node
      # Specify other node configuration settings as needed
    }
  }
}

