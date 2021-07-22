# Creamos un grupo de seguridad con una regla para el servicio ssh
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
resource "azurerm_network_security_group" "mySecGroup" {
    name                = "sshtraffic"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}

# Vinculamos el security group al interface de red del master node
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association
resource "azurerm_network_interface_security_group_association" "mySecGroupAssociation1" {
    count                     = length(var.Mastername)
    network_interface_id      = azurerm_network_interface.myNic1[count.index].id
    network_security_group_id = azurerm_network_security_group.mySecGroup.id

}

# Vinculamos el security group al interface de red de los worker nodes and nfs nodes
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association
resource "azurerm_network_interface_security_group_association" "mySecGroupAssociation2" {
    count                     = length(var.workers)
    network_interface_id      = azurerm_network_interface.myNic2[count.index].id
    network_security_group_id = azurerm_network_security_group.mySecGroup.id

}
