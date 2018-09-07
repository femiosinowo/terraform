# Configure the VMware vSphere Provider
provider "vsphere" {
    vsphere_server = "${var.vsphere_vcenter}"
    user = "${var.vsphere_user}"
    password = "${var.vsphere_password}"
    allow_unverified_ssl = true
}

# Build CentOS
resource "vsphere_virtual_machine" "centos-test" {
    name   = "centos-test"
    vcpu   = 2
    memory = 8192
    domain = "paosin.local"
    datacenter = "${var.vsphere_datacenter}"
    #cluster = "${var.vsphere_cluster}"

    # Define the Networking settings for the VM
    network_interface {
        label = "VM Network"
        ipv4_gateway = "10.10.10.1"
        ipv4_address = "10.10.10.41"
        ipv4_prefix_length = "24"
    }

    dns_servers = ["10.10.10.11", "8.8.8.8"]

    # Define the Disks and resources. The first disk should include the template.
    disk {
        template = "centos_template"
        datastore = "hdd2"
        type ="thin"
    }

    # Define Time Zone
    time_zone = "America/New_York"
}