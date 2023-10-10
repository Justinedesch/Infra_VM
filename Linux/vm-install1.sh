# vm-install1.sh

# Local path to hte iso
iso=/home/user/Desktop/iso/preseed-debian-12.1.0-amd64-netinst.iso
#domain type = 'kvm'
# Stop and undefined the VM
#/bin/virsh destroy $1; /bin/virsh undefine $1 -- remove-all-storage

#graphical console
#via local ISO
sudo virt-install \
--connect qemu:///system \
--virt-type kvm \
--check path_in_use=off \
--name=$1 \
--disk path=/var/lib/libvirt/images/$1.img,size=8 \
--ram=8192 \
--vcpus=4 \
--os-variant=debian12 \
--graphics vnc \
--console pty,target_type=serial \
--location=$iso
#--cdrom $iso
#domain

# Get ip adress of vm
# variable =  virsh domifaddr $1
#vm_macAddr=$(virsh dumpxml "$1" | grep "mac address" | awk -F' '{ print $2}')
#vm_ipv4=$(arp -an | grep "$vm_macAddr" | grep -Eo '([0-9]{1,3}.){3}[0-9]{1,3}')
#gnome-terminal --bash -c "ssh seb@$vm_ipv4; exec bash" 
# Do ssh-copy-id on seb user
# sudo ssh-copy-id seb@variable

# Do scp for transfert script AMP
# scp <FILE_TO_TRANSFERT> seb@variable:<DESTINATION_PATH>

# Find solution for execute script AMP auto on VM