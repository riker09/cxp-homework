variable "region_name" {
  description = "The AWS region to deploy into."
  type        = string
}

variable "org_name" {
  description = "The name of the organisation that owns all AWS resources."
  type        = string
  default     = "msg"
}

variable "department_name" {
  description = "The name of the department that owns all AWS resources."
  type        = string
  default     = "BrAM"
}

variable "solution_name" {
  description = "The name of the project that owns all AWS resources."
  type        = string
}

variable "solution_stage" {
  description = "The name of the current solution stage."
  type        = string
}

variable "solution_fqn" {
  description = "description"
  type        = string
}

variable "backend_name" {
  description = "The name of the S3 backend"
  type        = string
}