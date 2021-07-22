UNIR Caso Práctico
Este cáso práctico está diseñado para funcionar con Terraform-Ansible-Azure. Desplegará un ambiente Kubernetes conformado por:

1 Master
2 Workers
1 Servidor nfs




Preparación del entorno de ejecución
*) Clonamos repositorio

git clone git@github.com:adrianAriasMorago/Azure.git
*) Creamos los directorios donde persistiremos los datos



az login
*) Definimos el subscription id que utilizaremos. Reemplzar por el valor correspondiente a la subscripción que se quiere utilizar dentro de nuestra mv

az account set --subscription="927d0301-3031-467c-9b95-a3d0135304a7"
*) Creación de un Service Principal que utilizaremos en Terraform

az ad sp create-for-rbac --role="Contributor"
Habiendo creado nuestro Service Principal crearemos el archivo credentials.tf, el que contendrá los siguientes campos

provider "azurerm" {
  subscription_id = "Valor del id de subscripci&oacute;n que utilizaremos"
  client_id       = "Valor de appId obtenido en el paso anterior"
  client_secret   = "Valor de password obtenido en el paso anterior"
  tenant_id       = "Valor de tenant obtenido en el paso anterior"

  features {}
}


Estado local/remoto de Terraform
Es posible guardar nuestro estado de Terraform de forma remota. De esta manera, si tenemos cualquier problema con nuestro directorio de trabajo, o si trabajamos con otras personas en la misma solución el estado queda almacenado en la nube y podemos recuperar los últimos cambios de forma automática.




provider "azurerm" {
  features {}
  subscription_id = "XXXXXXX"
  client_id       = "XXXXXXX"
  client_secret   = "XXXXXXXX"
  tenant_id       = "XXXXXXXX"
}

Ubicación geográfica de la solución
Actualmente la solución está pensada para ejecutarse en "West Europe", si quisieras ejecutarla en otra ubicación sólo deberís cambiar el valor de "location" dentro de correccion-vars.tf

Nombre de la cuenta de almacenamiento
Deberás ingresar un valor para storage_account dentro de correccion-vars.tf

Generacion de clave publica privada

ssh-keygen -t rsa

user@localhost: ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/youruser/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in id_rsa.
Your public key has been saved in id_rsa.pub.
The key fingerprint is:
16:8e:e8:f2:1d:c9:b9:cf:43:9a:b3:3c:c1:1f:95:93 user@localhost

Esto creará una clave privada escrita en /home/user/.ssh/id_dsa y una clave pública escrita en /home/user/.ssh/id_dsa.pub.

continuación, tendrás que escribir la ubicación del archivo en el que deseas guardar la clave privada.
Enter file in which to save the key (/home/youruser/.ssh/id_rsa):

La key pública se guardará en la misma ubicación, con el mismo nombre de archivo, pero con la extensión .pub. 




Nombre de usuario para la conexión SSH
Si quisieras podrís elegir el nombre de usuario para conectarte a los servidores via SSH. Para poder seleccionar el nombre sólo debes cambiar el valor de "ssh_user" dentro de correccion-vars.tf

Prefijo de identificación único
Deberás ingresar un valor para prefix dentro de /variables.tf. Es un prefijo de texto que se utilizará para identificar recursos únicos.

A
Dirección IP pública con permisos de acceso
Deberás ingresar un valor para my_ip dentro de variables.tf. Es la dirección IP pública de la máquina desde la que se ejecuta Terraform + Ansible para poder conectar vía SSH

Ejecución

terraforn ini en la ruta donde esta el directorio con los ficheros .tf y una vez lanzado luego se lanza el terraforn apply



