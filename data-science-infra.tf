resource "google_storage_bucket" "data-science-bucket" {
    name = "data-science-data-bucket"
    location = "us-central1"
    force_destroy = true

    versioning{
        enabled = true
    }
}

resource "google_project_service" "notebooks" {
    provider = google
    service = "notebooks.googleapis.com"
    disable_on_destroy = true

}

resource "google_notebooks_instance" "data-science-notebook" {
    name = "data-science-notebook"
    location = "us-central1-a"
    machine_type = "e2-medium"
    vm_image {
        project = "deeplearning-platform-release"
        image_family = "tf-ent-2-9-cu113-notebooks"
    }

    depends_on = [
        google_project_service.notebooks
    ]
}

resource "google_dataproc_cluster" "data-science-cluster" {
    name = "data-science-cluster"
    project = "devops-training-402109"
    region = "us-central1"
    cluster_config{
        master_config {
            num_instances = 1
            machine_type = "n1-standard-1"
            disk_config{
                boot_disk_size_gb = 100
            }
        }
        worker_config {
            num_instances = 2
            machine_type = "n1-standard-1"
            disk_config{
                boot_disk_size_gb = 100
            }
        }

        software_config {
            image_version = "1.5-debian10"
        }
    }
}
