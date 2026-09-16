mock_provider "databricks" {}

variables {

  name                       = "etl-sp"
  allow_cluster_create       = false
  allow_instance_pool_create = false
  databricks_sql_access      = true
  workspace_access           = true
}

run "documented_example" {
  command = apply

  assert {
    condition     = databricks_service_principal.this.display_name == var.name
    error_message = "The resource must preserve its configured name."
  }
}

run "reject_blank_name" {
  command = plan
  variables {
    name = "  "
  }
  expect_failures = [var.name]
}

run "reject_conflicting_entitlements" {
  command = plan
  variables {
    workspace_consume = true
  }
  expect_failures = [databricks_service_principal.this]
}

run "accept_consume_only" {
  command = plan
  variables {
    workspace_consume     = true
    workspace_access      = false
    databricks_sql_access = false
  }
}
