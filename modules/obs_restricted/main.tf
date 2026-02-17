resource "random_id" "bucket_kms_key_id" {
  byte_length = 4
}

resource "opentelekomcloud_kms_key_v1" "bucket_kms_key" {
  key_alias       = "${var.bucket_name}-key-${random_id.bucket_kms_key_id.hex}"
  key_description = "${var.bucket_name} encryption key"
  pending_days    = 7
  is_enabled      = "true"
  tags            = var.tags
}

resource "opentelekomcloud_obs_bucket" "bucket" {
  bucket     = var.bucket_name
  acl        = "private"
  versioning = var.enable_versioning
  server_side_encryption {
    algorithm  = "kms"
    kms_key_id = opentelekomcloud_kms_key_v1.bucket_kms_key.id
  }

  dynamic "logging" {
    for_each = var.logging_enabled ? [1] : []
    content {
      agency        = var.logging_agency
      target_bucket = var.logging_target_bucket
      target_prefix = var.logging_target_prefix
    }
  }

  tags = var.tags
}
