resource "google_compute_address" "static_ip" {
  name = "my-static-ip"
  region = var.region 
}

resource "google_compute_instance" "default" {
  name = "${var.instance_name}"

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
        nat_ip = google_compute_address.static_ip.address
    }
  }

  tags = ["k8s-master"]
}

resource "google_compute_firewall" "allow_k8s_api" {
  name    = "allow-k8s-api"
  network = var.network  

  allow {
    protocol = "tcp"
    ports    = ["6443"]
  }

  source_ranges = ["0.0.0.0/0"]  
  target_tags = ["k8s-master"]  
}
