provider "azurerm" {
  features {}
}

module "virtual-machine" {
  source  = "kumarvna/virtual-machine/azurerm"
  version = "2.1.0"

  resource_group_name       = "rg-shared-westeurope-01"
  location                  = "westeurope"
  virtual_network_name      = "vnet-shared-hub-westeurope-001"
  subnet_name               = "snet-management"
  virtual_machine_name      = "win-machine"
  os_flavor                 = "windows"
  windows_distribution_name = "windows2019dc"
  virtual_machine_size      = "Standard_A2_v2"
  admin_username            = "azureadmin"
  admin_password            = "P@$$w0rd1234!"
  instances_count           = 1
  dns_servers               = ["10.1.3.4", "168.63.129.16"]

  nsg_inbound_rules = [
    {
      name                   = "rdp"
      destination_port_range = "3389"
      source_address_prefix  = "*"
    },

    {
      name                   = "http"
      destination_port_range = "80"
      source_address_prefix  = "*"
    },
  ]
}

module "domain-join" {
  source  = "kumarvna/domain-join/azurerm"
  version = "1.1.0"

  virtual_machine_id        = element(concat(module.virtual-machine.windows_virtual_machine_ids, [""]), 0)
  active_directory_domain   = "consoto.com"
  active_directory_username = "azureadmin"
  active_directory_password = "P@$$w0rd1234!"

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
