variable "virtual_machine_id" {
  description = "The resource ID of the Virtual Machine"
}

variable "active_directory_domain" {
  description = "The name of the Active Directory domain to join"
}

variable "ou_path" {
  description = "An organizational unit (OU) within an Active Directory to place computers"
  default     = null
}

variable "active_directory_username" {
  description = "The username of an account with permissions to bind machines to the Active Directory Domain"
}

variable "active_directory_password" {
  description = "The password of the account with permissions to bind machines to the Active Directory Domain"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
