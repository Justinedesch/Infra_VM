
#!/bin/bash
# fullInstallVMDebian.sh

chmod +x DebianVM.sh
chmod +x stackVM.sh

./DebianVM.sh $1
./stackVM.sh
