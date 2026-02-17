variable "bucket_name" {
  type        = string
  description = "Bucket name. Make sure the provider for this module has tennant_name=<region> set"
  validation {
    condition     = length("${var.bucket_name}-user") <= 32
    error_message = "The username for the bucket user may only be max 32 characters long."
  }
}

variable "enable_versioning" {
  type        = bool
  description = "Disable the versioning for the bucket. Default: true"
  default     = true
}

variable "tags" {
  type    = map(string)
  default = null
}

variable "logging_enabled" {
  description = "Enable OBS bucket logging"
  type        = bool
  default     = false
}

variable "logging_target_bucket" {
  description = "The name of the bucket to receive the log objects"
  type        = string
  default     = ""
}

variable "logging_target_prefix" {
  description = "The prefix for the log objects"
  type        = string
  default     = "log/"
}

variable "logging_agency" {
  description = "The IAM agency name for OBS bucket logging permissions"
  type        = string
  default     = null
}
