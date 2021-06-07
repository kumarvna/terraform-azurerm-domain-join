resource "azurerm_virtual_machine_extension" "join-domain" {
  name                       = "join-ad-domain"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true
  tags                       = merge({ "ResourceName" = "join-ad-domain" }, var.tags, )

  settings = <<SETTINGS
    {
        "Name": "${var.active_directory_domain}",
        "OUPath": ${var.ou_path} == null ? "" : ${var.ou_path},
        "User": "${var.active_directory_domain}\\${var.active_directory_username}",
        "Restart": "true",
        "Options": "3"
    }
SETTINGS

  protected_settings = <<SETTINGS
    {
        "Password": "${var.active_directory_password}"
    }
SETTINGS
}
