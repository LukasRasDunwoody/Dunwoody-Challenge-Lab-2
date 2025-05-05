provider "aws" {
  region = var.primary-region
  alias  = "primary"
}

provider "aws" {
  region = var.secondary-region
  alias  = "secondary"
}