#!/usr/bin/env bash

BASE_URL='https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/'
ISO=$(curl $BASE_URL 2>&1 | grep -Eo 'debian-[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}-amd64-netinst.iso' | head -1)

# Download latest ISO
[ ! -f iso/$ISO ] && curl -L --create-dirs -o iso/$ISO $BASE_URL$ISO || echo 'ISO file found. Skip.'

# Extract ISO
mkdir -p iso/iso-extract

# Extract just the necessary
xorriso -indev iso/$ISO \
    -osirrox on \
    -extract / iso/iso-extract/

# Add preseed.cfg and sources.list to initrd
chmod +w -R iso/iso-extract/install.amd/ && gunzip iso/iso-extract/install.amd/initrd.gz
echo preseed.cfg  | cpio -H newc -o -A -F iso/iso-extract/install.amd/initrd
echo sources.list | cpio -H newc -o -A -F iso/iso-extract/install.amd/initrd
gzip iso/iso-extract/install.amd/initrd && chmod -w -R iso/iso-extract/install.amd/

# Fix MD5
chmod +w iso/iso-extract/md5sum.txt
md5sum $(find iso/iso-extract -follow -type f) > iso/iso-extract/md5sum.txt
chmod -w iso/iso-extract/md5sum.txt

# Remove previous preseeded ISO
[ -e iso/preseed-$ISO ] && rm iso/preseed-$ISO || echo 'No previous preseeded ISO. Skip.'

# Create preseeded ISO
xorriso -outdev iso/preseed-$ISO \
    -map iso/iso-extract/ / \
    -boot_image isolinux dir=/isolinux \
    -boot_image isolinux system_area=/usr/lib/ISOLINUX/isohdpfx.bin \
    -boot_image any next \
    -boot_image any efi_path=boot/grub/efi.img \
    -boot_image isolinux partition_entry=gpt_basdat

# Remove ISO extract
sudo rm -rf iso/iso-extract