#Nombre de los nodo master
variable "Mastername" {
  description = "Maquinas virtuales"
  type = list(string)
  default = ["ks8master.azure"]
}


#Tipo de instancia para el nodo master
variable "size_B2s" {
  type = string
  description = "Tamano vm master"
  default = "Standard_B2s"
}

#nombres para los nodo worker y nodos nfs
variable "workers" {
  description = "Maquinas virtuales"
  type = list(string)
  default = ["k8sworker01.azure","k8sworker02.azure","nfsserver.azure"]
}


#Tipo de instancia para los nodos worker y nodo nfs
variable "size_BD1_v2" {
  type = string
  description = "Tamano para los workers y nfs"
  default = "Standard_DS1_v2"
}


