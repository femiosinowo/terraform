# Configure vlan and network params

#### NETWORK_VM_1 PORT CONFIG
# Create port frt with vlan
resource "vsphere_host_port_group" "network_port" {
  name                = "vm_network_1" #"${var.kube_node1_network_params["label"]}"
  host_system_id      = "${data.vsphere_host.host.id}"
  virtual_switch_name = "${var.vswitch}"
  vlan_id             = 1 #"${var.kube_node1_network_params["vlan_id"]}"
  allow_promiscuous   = true
  # Wait network creation
  provisioner "local-exec" {
    command           = "sleep 10"
  }
}
