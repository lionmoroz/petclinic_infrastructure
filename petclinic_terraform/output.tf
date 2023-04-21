output "petclinic_db_connection_name" {
  value = google_sql_database_instance.petclinic_db.connection_name
}

output "ip" {
  value = google_compute_instance.petclinic-app-tf.network_interface.0.network_ip
}
