variable "aws" {
  description = "AWS provider settings"

  default = {
    access_key = ""
    profile    = ""
    region     = "us-east-1"
    secret_key = ""
  }
}
