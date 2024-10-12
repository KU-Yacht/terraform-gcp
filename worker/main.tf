resource "google_compute_firewall" "allow-4430-external" {
  name    = "allow-external-4430"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["4430"]
  }

  source_ranges = ["0.0.0.0/0"]  
  target_tags   = ["kube-worker"] 
}

resource "google_compute_firewall" "allow-ingress-nodeports" {
  name    = "allow-ingress-nodeports"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["31595", "32759"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["kube-worker"]
}

resource "google_compute_address" "static_ip" {
  count  = var.worker_count
  name   = "my-static-ip-${count.index + 1}"
  region = var.region 
}

resource "google_compute_instance" "default" {
  count = var.worker_count
  name  = "${var.instance_name}-${count.index + 1}"
  machine_type = "${var.machine_type["e2-medium"]}"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "${var.instance_image["ubuntu20"]}"
      size = 10
    }
  }

  network_interface {
    network = "${var.network}"
    access_config {
        nat_ip = google_compute_address.static_ip[count.index].address
    }
  }

  tags = ["kube-worker"]

}
