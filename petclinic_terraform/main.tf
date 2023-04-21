data "google_compute_image" "my_image" {
  name = "petclinic-instance-image-v2"
  # could also use family = "family-name"
}

data "google_service_account" "petclinic_sa" {
  account_id = var.account_email
}

resource "google_compute_network" "petclinic_vpc" {
  name                    = var.vpc_name 
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "petclinic_subnet" {
  name          = var.subnetwork_name
  network       = google_compute_network.petclinic_vpc.self_link
  ip_cidr_range = var.ip_range 
  region        = var.region
}

resource "google_compute_firewall" "petclinic_allow_ssh" {
  name    = var.ssh_firewall_name
  network = google_compute_network.petclinic_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "petclinic_allow_http" {
  name    = var.http_firewall_name 
  network = google_compute_network.petclinic_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  target_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "petclinic_public_ip" {
  name = var.ip_name
}


resource "google_compute_instance" "petclinic-app-tf" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["ssh", "web"]

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.my_image.self_link}"
    }
  }
  
  network_interface {
    network = google_compute_network.petclinic_vpc.name
    subnetwork = google_compute_subnetwork.petclinic_subnet.name


    access_config {
      nat_ip = google_compute_address.petclinic_public_ip.address
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "${data.google_service_account.petclinic_sa.email}"
    scopes = ["cloud-platform"]
}
}

resource "random_id" "instance_id" {
  byte_length = 8
}

resource "google_compute_global_address" "private_ip_address" {
  name          = var.privat_ip_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.petclinic_vpc.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = google_compute_network.petclinic_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}


resource "google_sql_database_instance" "petclinic_db" {
  name = "petclinic-db-tf-${random_id.instance_id.hex}"
  region = "${var.region}"

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-n1-standard-1"
    ip_configuration {
      ipv4_enabled = false
      private_network = google_compute_network.petclinic_vpc.id
    }
  }
  database_version = "MYSQL_5_7"
  root_password = var.set_root_password

  deletion_protection = false
  
}

resource "google_sql_user" "petclinic_user" {
  name = var.database_user
  instance = google_sql_database_instance.petclinic_db.name
  password = var.database_password
}

resource "google_sql_database" "petclinic_database" {
  name = var.name_database 
  instance = google_sql_database_instance.petclinic_db.name
}


