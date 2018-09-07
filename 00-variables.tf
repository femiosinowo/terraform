# Configure the VMware vSphere Provider
# You can use vcenter login params or simply host esxi login params
provider "vsphere" {
  # If you use a domain set your login like this "MyDomain\\MyUser"
  user           = "${var.vcenter_user}"
  password       = "${var.vcenter_password}"
  vsphere_server = "${var.vsphere_server}"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

#### TEMPLATES
variable "vcenter_user" {}
variable "vcenter_password" {}
variable "vsphere_server" {}


# You must add template in vsphere before use it
variable "template_image" {
  default = "centos-7-template-esxi"
}

#### DC AND CLUSTER
# Set vpshere datacenter
variable "dc" {
  default = "paosin.local"
}

# Set cluster where you want deploy your vm
variable "cluster" {
  default = "paosin-cluster"
}

# Set host where you want deploy your vm
variable "host" {
  default = "10.10.10.2"
}

#### GLOBAL NETWORK PARAMS
# Virtual switch used
variable "vswitch" {
  default = "vSwitch0"
}

variable "dns_servers" {
  default = ["10.10.10.11", "8.8.4.4"]
}

#### PARAMS SERVER_ONE INSTANCES #####################################
#
#
#
variable "server1_vm_params" {
  default = {
    hostname       = "server1"
    vcpu           = "2"
    ram            = "4096"
    # You can't set a datastore name with interspace
    disk_datastore = "hdd2"
    disk_size      = "15"
  }
}

variable "server1_network_params" {
  default = {
    domain           = "test.local"
    label            = "vm_network_1"
    vlan_id          = "1"
    ipv4_address     = "192.168.1.1"
    prefix_length    = "24"
    gateway          = "192.168.1.254"
  }
}

#### PARAMS SERVER_TWO INSTANCES #######################################
#
#
#
variable "server2_vm_params" {
  default = {
    hostname       = "server2"
    vcpu           = "2"
    ram            = "2048"
    # You can't set a datastore name with interspace
    disk_datastore = "hdd2"
    disk_size      = "15"
  }
}

variable "server2_network_params" {
  default = {
    domain           = "test.local"
    label            = "vm_network_1"
    vlan_id          = "1"
    ipv4_address     = "192.168.1.2"
    prefix_length    = "24"
    gateway          = "192.168.1.254"
  }
}
