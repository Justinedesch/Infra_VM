
#!/bin/bash
# vm-install1.sh

echo creating $1
# local path to the iso
iso=/home/justine.deschamps@Digital-Grenoble.local/Documents/debian-testing-amd64-DVD-1-001.iso

# Stop and undefine the VM
#/bin/virsh destroy $1; /bin/virsh undefine $1 --remove-all-storage

# graphical console
# via local ISO
virt-install \
--virt-type kvm \
--check path_in_use=off \
--connect qemu:///system \
--name=$1 \
--disk path=/var/lib/libvirt/images/$1.img,size=8 \
--ram=1024 \
--vcpus=2 \
--os-variant=debiantesting \
--initrd-inject=preseed.cfg \
--graphics vnc \
--console pty,target_type=serial \
--location=$iso
#/etc/libvirt/qemu.conf
#sudo -s


