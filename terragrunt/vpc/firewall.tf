resource "google_compute_firewall" "default" {
  name    = "allow-web"
  project = var.project_for_firewall
  network = var.network_name_for_firewall

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

variable "network_name_for_firewall" {
  type = string
}

variable "project_for_firewall" {
  type = string
}