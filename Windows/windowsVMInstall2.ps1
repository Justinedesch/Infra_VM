

$VMName = "vm2"
$VMPath = "D:\Infra-VM"  # le chemin de la VM
$VMMemory = 2048MB  #  la quantité de mémoire
$VMDiskSize = 32GB  #  la taille du disque dur
$ISOPath = "D:\Infra-VM\Windows" #  le chemin de l'ISO de Windows Server# Créez un nouveau disque dur virtuel pour la VM

Add-VMDvdDrive -VMName $VMName -Path $ISOPath -ControllerLocation 0 -ControllerNumber 1
New-VHD -Path "$VMPath$VMName.vhdx" -SizeBytes $VMDiskSize -Dynamic

#Créez une nouvelle machine virtuelle
New-VM -Name $VMName -MemoryStartupBytes $VMMemory -Path $VMPath

#joign le disque dur virtuel à la VM
Add-VMHardDiskDrive -VMName $VMName -Path "$VMPath$VMName.vhdx"

#joigne l'ISO de Windows Server à la VM
Add-VMDvdDrive -VMName $VMName -Path $ISOPath

#Démarrez la VM
Start-VM -Name $VMName