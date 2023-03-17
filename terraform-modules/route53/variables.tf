variable "common_tags" {
  description = "Common tags to be applied to all AWS resources"
  type        = map(string)
}

variable "instance_public_ip" {
  description = "The IP of the instance to resolve to"
}