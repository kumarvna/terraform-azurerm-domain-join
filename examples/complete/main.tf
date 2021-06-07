module "key-vault" {
  source  = "kumarvna/domain-join/azurerm"
  version = "1.0.0"

  virtual_machine_id        = var.virtual_machine_id
  active_directory_domain   = "conteso.com"
  active_directory_username = "testuser"
  active_directory_password = "P@$$w0rd123!"

  # Adding TAG's to your Azure resources (Required)
  # ProjectName and Env are already declared above, to use them here or create a varible. 
  tags = {
    ProjectName  = "demo-project"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}
