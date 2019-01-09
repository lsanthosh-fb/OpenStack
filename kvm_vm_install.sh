#!/bin/bash
undercloud_name=vm-kvm 
undercloud_suffix=local 
root_password=<passowrd>
stack_password=<password>
cloud_image=/home/lance/rhel-server-7.5-update-4-x86_64-kvm.qcow2
export LIBGUESTFS_BACKEND=direct 
qemu-img create -f qcow2 /home/lance/${undercloud_name}.qcow2 100G 
virt-resize --expand /dev/sda1 ${cloud_image} /home/lance/${undercloud_name}.qcow2 
virt-customize -a /home/lance/${undercloud_name}.qcow2 --run-command 'xfs_growfs /' --root-password password:${root_password} --hostname ${undercloud_name}.${undercloud_suffix} --run-command 'useradd teoco' --password stack:password:${stack_password} --run-command 'echo "stack ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/stack' --chmod 0440:/etc/sudoers.d/stack --run-command 'sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config' --run-command 'systemctl enable sshd' --run-command 'yum remove -y cloud-init' --selinux-relabel

#Define the undercloud virsh template
vcpus=4 
vram=8192
virt-install --name ${undercloud_name} --disk /home/lance/${undercloud_name}.qcow2 --vcpus=${vcpus} --ram=${vram} --network network=default,model=virtio --virt-type kvm --import --os-variant rhel7 --graphics vnc --serial pty --noautoconsole --console pty,target_type=virtio
