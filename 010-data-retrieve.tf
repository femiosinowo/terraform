#### GLOBAL CONFIG DC AND HOST
# Define datacenter
data "vsphere_datacenter" "dc" {
  name = "${var.dc}"
}

# Exctrat data port vlan creation
data "vsphere_host" "host" {
  name          = "${var.host}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

 

# Retrieve datastore information on vsphere
data "vsphere_datastore" "datastore" {
  name          = "${var.kube_node1_vm_params["disk_datastore"]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# Retrieve network information on vsphere
data "vsphere_network" "network" {
  name          = "${var.kube_node1_network_params["label"]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
  depends_on    = ["vsphere_host_port_group.network_port"]
}

# Retrieve template information on vsphere
data "vsphere_virtual_machine" "template" {
  name          = "${var.template_image}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
