terraform {
  backend "s3" {
    region         = "us-west-1"
    bucket         = "s3-us-west-1-cxp-starfleet-tf-state"
    dynamodb_table = "dyn-us-west-1-cxp-starfleet-tf-state"
    key            = "starfleet/tfstate"
  }
}