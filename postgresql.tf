resource "random_string" "db_password" {
  length  = 16
  special = true
}

resource "google_sql_database_instance" "postgres_db" {
  project = var.project_id
  region = var.region
  name             = "postgres-instance"
  database_version = "POSTGRES_15"
  root_password = random_string.db_password.result
  

  settings {
    tier = "db-f1-micro"
    availability_type = "ZONAL"

    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name = "datastream"
        value = "104.199.6.64/32"
      }

      authorized_networks {
        name = "datastream"
        value = "34.78.213.130/32"
      }

      authorized_networks {
        name = "datastream"
        value = "35.205.33.30/32"
      }

      authorized_networks {
        name = "datastream"
        value = "35.205.125.111/32"
      }

      authorized_networks {
        name = "datastream"
        value = "35.187.27.174/32"
      }
    }

    database_flags {
      name  = "cloudsql.logical_decoding"
      value = "on"
    }

    database_flags {
      name  = "log_statement"
      value = "all"
    }


    backup_configuration {
      enabled = true
    }

    maintenance_window {
      day  = 5
      hour = 23
    }
  }
  deletion_protection = false
}

resource "google_sql_database" "database" {
  project  = var.project_id
  name     = var.postgresql_db
  instance = google_sql_database_instance.postgres_db.name
}

resource "google_secret_manager_secret" "db_password" {
  project = var.project_id
  secret_id = "postgres-db-password"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password_v1" {
  secret = google_secret_manager_secret.db_password.name
  secret_data = random_string.db_password.result
}