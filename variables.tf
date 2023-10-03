variable "project_id" {
  description = "The project ID to deploy to"
}

variable "region" {
  description = "The region to deploy to"
}

variable "postgresql_db" {
  description = "The name of the PostgreSQL database to create and replicate to BQ"
}

variable "publication" {
  description = "The name of the PostgreSQL publication to replicate"
}

variable "replication_slot" {
  description = "The name of the PostgreSQL replication slot to use"
}