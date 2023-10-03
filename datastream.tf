# resource "google_datastream_connection_profile" "source" {
#     project = var.project_id
#     display_name          = "Postgresql Source"
#     location              = var.region
#     connection_profile_id = "psql-source-profile"

#     postgresql_profile {
#         hostname = google_sql_database_instance.postgres_db.ip_address[0].ip_address
#         port     = 5432
#         username = "postgres"
#         password = google_secret_manager_secret_version.db_password_v1.secret_data
#         database = "postgres"
#     }
# }

# resource "google_datastream_connection_profile" "destination" {
#     project = var.project_id
#     display_name          = "BigQuery Destination"
#     location              = var.region
#     connection_profile_id = "bq-destination-profile"

#     bigquery_profile {}
# }

# resource "google_datastream_stream" "default"  {
#     project = var.project_id
#     display_name = "Postgres to BigQuery"
#     location     = var.region
#     stream_id    = "psql-to-bq-stream"
#     desired_state = "RUNNING"

#     source_config {
#         source_connection_profile = google_datastream_connection_profile.source.id
#         postgresql_source_config {
#             publication      = var.publication
#             replication_slot = var.replication_slot

#             include_objects {
#                 postgresql_schemas {
#                     schema = var.postgresql_db
#                 }
#             }
#         }
#     }

#     destination_config {
#         destination_connection_profile = google_datastream_connection_profile.destination.id
#         bigquery_destination_config {
#             data_freshness = "0s"
#             source_hierarchy_datasets {
#                 dataset_template {
#                    location = "EU"
#                 }
#             }
#         }
#     }

#     backfill_all {}
# }