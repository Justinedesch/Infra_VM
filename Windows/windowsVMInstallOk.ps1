$isoFile = 'D:\Infra-VM\Windows\SERVER_EVAL_x64FRE_en-us.iso'
$vmName = 'VMWindows'
$pass = 'Wololo0222!'

D:\Infra-VM\Windows\New-VMFromWindowsImage.ps1 -SourcePath $isoFile -Edition "Windows Server 2022 Standard Evaluation (Desktop Experience)" -VMName $vmName -VHDXSizeBytes 120GB -AdministratorPassword $pass  -Version 'Server2022Standard' -MemoryStartupBytes 2GB -VMProcessorCount 4

$sess = D:\Infra-VM\Windows\New-VMSession.ps1 -VMName $vmName -AdministratorPassword $pass


D:\Infra-VM\Windows\Enable-RemoteManagementViaSession.ps1 -Session $sess 

#You can run any commands on VM with Invoke-Command:
Invoke-Command -Session $sess { 
    echo "Hello, world! (from $env:COMPUTERNAME)"

    # Install chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    # Install 7-zip
    choco install 7zip -y

    # Install MariaDBD
	choco install mariadb.install
    choco install mariadb
 
    # Install iis 
    choco install iis.administration -y
}



Remove-PSSession -Session $sess