#### SERVER_ONE ####
#
# Create vm with template
#
#### PARAMS kube_node1 INSTANCES #####################################
#
#
#


variable "kube_node1_vm_params" {
  default = {
    hostname       = "kube_node1"
    vcpu           = "2"
    ram            = "4096"
    # You can't set a datastore name with interspace
    disk_datastore = "hdd2"
    disk_size      = "16"
  }
}

variable "kube_node1_network_params" {
  default = {
    domain           = "paosin.local"
    label            = "vm_network_1"
    vlan_id          = "1"
    ipv4_address     = "10.10.10.72"
    prefix_length    = "24"
    gateway          = "10.10.10.1"
  }
}


###########################
Resources
##################################

resource "vsphere_virtual_machine" "kube_node1" {
  name                   = "${var.kube_node1["hostname"]}"
  num_cpus               = "${var.kube_node1["vcpu"]}"
  memory                 = "${var.kube_node1["ram"]}"
  datastore_id           = "${data.vsphere_datastore.datastore.id}"
  host_system_id         = "${data.vsphere_host.host.id}"
  resource_pool_id       = "${data.vsphere_resource_pool.pool.id}"
  guest_id               = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type              = "${data.vsphere_virtual_machine.template.scsi_type}"

# Configure network interface
  network_interface {
    network_id          = "${data.vsphere_network.network.id}"
  }

# Configure Disk
  disk {
    name                = "${var.kube_node1["hostname"]}.vmdk"
    size                = "16"
  }

# Define template and customisation params
  clone {
    template_uuid       = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name       = "${var.kube_node1["hostname"]}"
        domain          = "${var.kube_node1_network_params["domain"]}"
      }

      network_interface {
        ipv4_address    = "${var.kube_node1_network_params["ipv4_address"]}"
        ipv4_netmask    = "${var.kube_node1_network_params["prefix_length"]}"
        dns_server_list = "${var.dns_servers}"
      }

      ipv4_gateway      = "${var.kube_node1_network_params["gateway"]}"
    }
  }
  depends_on            = ["vsphere_host_port_group.network_port"]
}
