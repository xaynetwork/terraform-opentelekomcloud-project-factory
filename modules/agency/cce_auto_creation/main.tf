resource "opentelekomcloud_identity_agency_v3" "enable_cce_auto_creation" {
  name                  = "cce_admin_trust"
  description           = "Created by Terraform to auto create cce"
  delegated_domain_name = "op_svc_cce"
  dynamic "project_role" {
    for_each = var.projects
    content {
      project = project_role.value
      roles = [
        "Tenant Administrator"
      ]
    }
  }
}