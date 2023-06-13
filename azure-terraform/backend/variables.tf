variable "region_name" {
  description = "Name of an Azure region that hosts this solution (like West Europe)"
  type        = string
}

variable "region_code" {
  description = "Code of an Azure region that hosts this solution (like westeu for West Europe)"
  type        = string
}

variable "solution_name" {
  description = "Name of this Azure solution"
  type        = string
}

variable "solution_stage" {
  description = "Stage of this Azure solution"
  type        = string
}

variable "backend_configuration_file" {
  description = "Path name of a Terraform backend configuration file supposed to contain partial backend configuration values; not created if left empty"
  type        = string
  default     = ""
}