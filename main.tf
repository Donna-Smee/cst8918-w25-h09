resource "azurerm_resource_group" "kube-rg" {
  name     = "${var.labelPrefix}-Kube-RG"
  location = var.region
}

resource "azurerm_kubernetes_cluster" "kube-cluster" {
  name                = "${var.labelPrefix}-aks"
  location            = azurerm_resource_group.kube-rg.location
  resource_group_name = azurerm_resource_group.kube-rg.name
  dns_prefix          = "aks-cluster"
  kubernetes_version  = "1.32.0"
  node_resource_group = "aks-node-rg"

  sku_tier = "Free"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_B2s"
    max_count           = 3
    min_count           = 1
    enable_auto_scaling = true
    type                = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}


output "kube_config" {
  value = azurerm_kubernetes_cluster.kube-cluster.kube_config_raw

  sensitive = true
}

