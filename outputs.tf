output "bucket_name"{
    value = google_storage_bucket.data-science-bucket.name
}

output "notebook_instance_name" {
    value = google_notebooks_instance.data-science-notebook.name
}

output "cluster_name" {
    value = google_dataproc_cluster.data-science-cluster.name
}