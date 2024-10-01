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
}