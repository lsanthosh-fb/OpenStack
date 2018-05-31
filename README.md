# OpenStack
OpenStack Operations and configuration

Image Creation:- 
===============

glance image-create --name <name> --disk-format qcow2 --container-format bare --progress --visibility public --property hw_disk_bus=ide --property hw_cdrom_bus=ide --file <file_name>.qcow2 <IMAGE_NAME>
  
openstack image create --disk-format qcow2 --container-format bare  --public --property hypervisor_type=qemu --property os_type=<windows> --file ./<file_name>.qcow2 <IMAGE_NAME>
  
Flavour creation:-
================
nova flavor-create <FLAVOR_NAME> auto 32768 50 8

openstack flavor create --ram 32768 --disk 550 --vcpus 16 --public 16c32r550d

Network Creation:-
=================
neutron net-create CLOUD1-GW-BASE-INT-NET --shared

openstack subnet create <SUBNET_NAME> --project <PROJECT_ID> --subnet-range 10.101.200.0/24 --allocation-pool start=10.101.200.11,end=10.101.200.100 --gateway 10.101.200.1 --network <NET_NAME> --service-type 'compute:nova'

Subnet Creation:-
===============
neutron subnet-create --allocation-pool start=10.101.101.11,end=10.101.101.100 --gateway 10.101.101.1 --enable-dhcp <NET NAME> 10.101.101.0/24 --name <SUBNET NAME>

Port Creation:-
==============
neutron port-create <PORT_ID/NAME> --fixed-ip subnet_id=<subnet_id>,ip_address=169.254.50.71 --name <PORT_NAME>

neutron port-update <PORT_ID/NAME> --allowed-address-pairs type=dict list=true ip_address=10.101.200.201

openstack port set --allowed-address ip-address=172.16.50.164 <PORT_NAME>

openstack port create --network <NET_ID/NAME> --fixed-ip subnet=<SUBNET_ID>,ip-address=169.254.50.71 <PORT_NAME>


Nova Boot:-
==========
nova boot --image <IMAGE_NAME> --flavor <FLAVOR_NAME> --security-groups default --nic port-id=<PORT_ID> --nic net-id=<NET_NAME> --availability-zone <COMPUTE_NAME> --user-data <config_file>.xml --config-drive=true <VM_NAME>

openstack server create --flavor <FLAVOR_NAME> --image <IMAGE_NAME> --nic net-id=<NIC ID> VM_NAME
