# backend for aws
terraform {
  backend "s3" {
    bucket       = "terraform-state-lras"
    key          = "challengelab2/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
