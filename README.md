# Databricks service principal Terraform module

One service principal.

Creates one Databricks service principal with its entitlements. Databricks generates the application id.

## Resources

- `databricks_service_principal.this`

The resource addresses above are part of the DataTF import contract. Do not rename them.

## Usage

```hcl
module "service_principal" {
  source  = "536tech/service-principal/databricks"
  version = "0.1.0"

  name                       = "etl-sp"
  allow_cluster_create       = false
  allow_instance_pool_create = false
  databricks_sql_access      = true
  workspace_access           = true
}
```

## Compatibility

Configure the Databricks provider in the calling root with a workspace endpoint.
This resource module is also used by the
[workspace pattern module](https://registry.terraform.io/modules/536tech/workspace/databricks/latest).
Each repository has its own releases. Consumers select an exact tested module version.

The resource addresses match the original workspace submodule in version 0.1.1.
To migrate a direct submodule call, change its source and version. Keep the module block name.
Run `terraform init` and require a plan with no resource changes.
DataTF exports continue to use the workspace pattern module and its existing import addresses.

## Development

Use Terraform 1.7 or later for the mock tests. The module supports Terraform 1.5 or later.

```sh
prek install
terraform init -backend=false -lockfile=readonly
terraform validate
terraform test
tflint --recursive
prek run --all-files
```

CI tests the committed provider version and the minimum supported provider, 1.128.0.
The workspace pattern module checks the complete DataTF contract and its integration behavior.

## License

[Apache-2.0](LICENSE).

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- terraform (>= 1.5.0)

- databricks (>= 1.128.0, < 2.0.0)

## Providers

The following providers are used by this module:

- databricks (>= 1.128.0, < 2.0.0)

## Resources

The following resources are used by this module:

- [databricks_service_principal.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/service_principal) (resource)

## Required Inputs

The following input variables are required:

### allow\_cluster\_create

Description: Let the service principal create clusters.

Type: `bool`

### allow\_instance\_pool\_create

Description: Let the service principal create instance pools.

Type: `bool`

### databricks\_sql\_access

Description: Give the service principal access to Databricks SQL.

Type: `bool`

### name

Description: Key that identifies the service principal in tfvars. Used as the display name fallback.

Type: `string`

### workspace\_access

Description: Give the service principal access to the workspace.

Type: `bool`

## Optional Inputs

The following input variables are optional (have default values):

### display\_name

Description: Display name. Set it when the tfvars key had to be disambiguated.

Type: `string`

Default: `null`

### workspace\_consume

Description: Give the service principal the consume-only entitlement. The provider rejects it together  
with workspace\_access or databricks\_sql\_access, so the module sends it only when true.

Type: `bool`

Default: `null`

## Outputs

The following outputs are exported:

### application\_id

Description: Service principal application id.

### display\_name

Description: Service principal display name.

### id

Description: Service principal id.
<!-- END_TF_DOCS -->
