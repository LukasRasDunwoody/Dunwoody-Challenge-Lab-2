variable "primary-region" {
  type        = string
  default     = "us-east-1"
  description = "primary region for your infrastructure"
}

variable "secondary-region" {
  type        = string
  default     = "us-west-2"
  description = "secondary region for your infrastructure"
}