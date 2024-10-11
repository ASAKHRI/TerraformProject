
# Création du bucket Cloud Storage
# Spécifique à GCP : Utilisation de la ressource google_storage_bucket
resource "google_storage_bucket" "function_bucket" {
  name     = "mo-bucket-t" 
  force_destroy = true
  location = "US"                 
}

resource "google_storage_bucket_object" "ventes_file" {
  name   = "csv/ventes.csv" 
  bucket = google_storage_bucket.function_bucket.name
  source = "data_csv/ventes.csv"
}
resource "google_storage_bucket_object" "stocks_file" {
  name   = "csv/stocks.csv" 
  bucket = google_storage_bucket.function_bucket.name
  source = "data_csv/stocks.csv"
}
resource "google_storage_bucket_object" "clients_file" {
  name   = "csv/clients.csv" 
  bucket = google_storage_bucket.function_bucket.name
  source = "data_csv/clients.csv"
}
resource "google_storage_bucket_object" "produits_file" {
  name   = "csv/produits.csv" 
  bucket = google_storage_bucket.function_bucket.name
  source = "data_csv/produits.csv"
}
