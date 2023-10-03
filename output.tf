output "postgres_instance_public_ip" {
  value = google_sql_database_instance.postgres_db.ip_address[0].ip_address
}

output "db_password_secret_name" {
  value = google_secret_manager_secret.db_password.name
}