variable region {
  type        = string
  default     = "europe-west1"
  description = "Default regione"
}

variable project_id {
  type        = string
  description = "Set project id"
}


variable account_email {
  type        = string
  default     = "petclinic-sa@pllug-2022-melnyk.iam.gserviceaccount.com"
}

variable vpc_name {
  type        = string
  default     = "petclinic-vpc-tf"
}

variable subnetwork_name {
  type        = string
  default     = "petclinic-subnet-tf-eu-west1"
}

variable ip_range {
  type        = string
  default     = "10.24.5.0/24"
}

variable ssh_firewall_name {
  type        = string
  default     = "petclinic-allow-ssh-tf"
}

variable http_firewall_name {
  type        = string
  default     = "petclinic-allow-http-tf"
}

variable ip_name {
  type        = string
  default     = "petclinic-public-ip-tf"
}

variable instance_name {
  type        = string
  default     = "petclinic-app-tf"
}

variable machine_type {
  type        = string
  default     = "f1-micro"
}

variable zone {
  type        = string
  default     = "europe-west1-b"
}


variable privat_ip_name {
  type        = string
  default     = "private-ip-address"
}

variable set_root_password {
  type        = string
  default     = "petclinic"
  description = "Set root password for database"
}

variable database_user {
  type        = string
  default     = "petclinic"
  description = "Set database user"
}


variable database_password {
  type        = string
  default     = "petclinic"
  description = "Set database user password"
}

variable name_database {
  type        = string
  default     = "petclinic"
}
