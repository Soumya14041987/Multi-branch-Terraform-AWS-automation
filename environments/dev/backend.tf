terraform {
  backend "s3" {
    bucket         = "mywebappbucket-2024"
    path           = "/env/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
