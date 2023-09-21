provider "google" {
  credentials = file("/home/sreeramvellanki/sreeram_training/gcp-practice/terraform-gcp-serviceaccount-key.json")
  project     = "robotic-circle-359714"
  region      = "northamerica-northeast2"  # Change to your desired region
}