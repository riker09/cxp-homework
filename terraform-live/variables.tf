variable "region_name" {
  type        = string
  default     = "us-west-1"
  description = "The AWS region to deploy into"
}

variable "org_name" {
  type        = string
  default     = "msg"
  description = "The name of the organisation that owns all AWS resources."
}

variable "department_name" {
  type        = string
  default     = "BrAM"
  description = "The name of the department that owns all AWS resources."
}

variable "solution_name" {
  type        = string
  default     = "Startfleet"
  description = "The name of the project that owns all AWS resources."
}

variable "solution_stage" {
  type        = string
  default     = "DEV"
  description = "The name of the current solution stage."
}

variable "solution_fqn" {
  type        = string
  default     = ""
  description = "description"
}

variable "network_name" {
  type        = string
  default     = ""
  description = "description"
}

variable "network_cidr" {
  type        = string
  default     = ""
  description = "description"
}

variable "network_two_cidr" {
  type        = string
  default     = ""
  description = "description"
}
variable "network_two_name" {
  type        = string
  default     = ""
  description = "description"
}
