
# Création de l'archive zip contenant le code de la fonction
# Non spécifique à GCP, mais nécessaire pour le déploiement de la fonction
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "function_code"  # À MODIFIER si besoin : Chemin vers le code de votre fonction
  output_path = "cloudfunctions/function.zip"
}

# Upload du code de la fonction dans le bucket
# Spécifique à GCP : Utilisation de la ressource google_storage_bucket_object
resource "google_storage_bucket_object" "function_code" {
  name   = "function-${data.archive_file.function_zip.output_md5}.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = data.archive_file.function_zip.output_path
}

# Création de la Cloud Function 2nd Gen
# Spécifique à GCP : Utilisation de la ressource google_cloudfunctions2_function
resource "google_cloudfunctions2_function" "function" {
  name        = "function-t" 
  location    = "us-central1" 
  description = "My Cloud Function with terraform"

  build_config {
    runtime     = "python312" 
    entry_point = "hello_http"
    source {
      storage_source {
        bucket = google_storage_bucket.function_bucket.name
        object = google_storage_bucket_object.function_code.name
      }
    }
  }

  service_config {
    max_instance_count = 1        
    available_memory   = "512M" 
    timeout_seconds    = 120     
  }
}
