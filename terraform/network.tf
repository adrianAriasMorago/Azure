# Creación de la red 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "myNet" {
    name                = "kubernetesnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = "CP2"
    }
}

# Creación de la subnet 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "mySubnet" {
    name                   = "terraformsubnet"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.myNet.name
    address_prefixes       = ["10.0.10.0/24"]

}


# Creamos la tarjeta del nodo Maestro
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "myNic1" {
  name                = "vmnic${var.Mastername[count.index]}"
  count               = length(var.Mastername)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration${var.Mastername[count.index]}"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.10.${count.index + 10}"
    public_ip_address_id           = azurerm_public_ip.myPublicIp1[count.index].id
  }

    tags = {
        environment = "CP2"
    }

}

# Le asignamos una IP publica al nodo Maestro
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "myPublicIp1" {
  count               = length(var.Mastername)
  name                = "PublicIP${var.Mastername[count.index]}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}

## Nodo Mestro y nodo NFS ###

# Creamos la tarjeta de Red de los Worker nodes y el servidor NFS
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "myNic2" {
  name                = "vmnic${var.workers[count.index]}"
  count               = length(var.workers)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration${var.workers[count.index]}"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.10.${count.index + 20}"
    public_ip_address_id           = azurerm_public_ip.myPublicIp2[count.index].id
  }

    tags = {
        environment = "CP2"
    }

}

# Creamos una IP pública para los nodos worker y el servidor NFS
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "myPublicIp2" {
  count               = length(var.workers)
  name                = "PublicIP${var.workers[count.index]}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}
