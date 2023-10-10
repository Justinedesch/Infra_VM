# Variables
$VM1 = "WinVM1"                                        # Name of VM1
$VM1RAM = 4096MB                        # RAM assigned to VM1
$VM1VHD = 32GB                                # Size of Hard-Drive for VM1
$VMLOC = "D:\Infra-VM"                            # Location of the VM and VHDX files
$NetworkSwitch1 = "VirtualSwitch1"
$ISO = "D:\Infra-VM\Windows\SERVER_EVAL_x64FRE_en-us.ISO"               # Windows ISO

# Create VM Folder and Network Switch
MD $VMLOC -ErrorAction SilentlyContinue
$TestSwitch = Get-VMSwitch -Name $NetworkSwitch1 -ErrorAction SilentlyContinue; if ($TestSwitch.Count -EQ 0){New-VMSwitch -Name $NetworkSwitch1 -SwitchType Private}

# Create Virtual Machines
New-VM -Name $VM1 -Path $VMLOC  -NewVHDPath $VMLOC\$VM1.vhdx -MemoryStartupBytes $VM1RAM -NewVHDSizeBytes $VM1VHD -SwitchName $NetworkSwitch1 


# Configure Virtual Machines

Set-VMProcessor $VM1 -Count 6  
Start-DscConfiguration -Path D:\Infra-VM\Windows\config.ps1 -Verbose -Wait

#Adding DVD Drive to mount ISO

Add-VMDvdDrive -VMName $VM1 -Path $ISO 


#Changing Boot Order to FirstBootDevice as DVD

$dvd = Get-VMDvdDrive -VMName $VM1
Set-VMFirmware -VMName $VM1 -FirstBootDevice $dvd
Set-VMDvdDrive -VMName $VM1 -Path $ISO

#Adding a corporate virtual switch
Add-VMNetworkAdpater -VMName $VM1 -SwitchName $VirtualSwitch1

Start-VM $VM1
