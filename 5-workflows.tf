resource "google_workflows_workflow" "my_workflow" {
  name     = "workflow_terraform"
  region   = "us-central1"
  source_contents = file("workflow.yaml")
}
 
output "workflow_name" {
  value = google_workflows_workflow.my_workflow.name
}
