### Localization
# Preseeding only locale sets language, country and locale.
d-i debian-installer/locale string fr_FR.UTF-8

# The values can also be preseeded individually for greater flexibility.
d-i debian-installer/language string fr
d-i debian-installer/country string FR
# Optionally specify additional locales to be generated.
d-i localechooser/supported-locales multiselect fr_FR.UTF-8

# Keyboard selection.
d-i console-setup/ask_detect boolean true
d-i keyboard-configuration/xkb-keymap select fr
d-i keyboard-configuration/layoutcode string fr
d-i keyboard-configuration/variantcode alt
d-i keyboard-configuration/toggle select legacy

### Network configuration
# Disable network configuration entirely. This is useful for cdrom
# installations on non-networked devices where the network questions,
# warning and long timeouts are a nuisance.
d-i netcfg/enable boolean true

# netcfg will choose an interface that has link if possible. This makes it
# skip displaying a list if there is more than one interface.
d-i netcfg/choose_interface select auto
#d-i netcfg/choose_interface select enp0s25

# To set a different link detection timeout (default is 3 seconds).
# Values are interpreted as seconds.
#d-i netcfg/link_wait_timeout string 10

# If you have a slow dhcp server and the installer times out waiting for
# it, this might be useful.
#d-i netcfg/dhcp_timeout string 60
#d-i netcfg/dhcpv6_timeout string 60

# If you prefer to configure the network manually, uncomment this line and
# the static network configuration below.
#d-i netcfg/disable_autoconfig boolean true
d-i netcfg/disable_autoconfig boolean false

# If you want the preconfiguration file to work on systems both with and
# without a dhcp server, uncomment these lines and the static network
# configuration below.
d-i netcfg/dhcp_failed note
d-i netcfg/dhcp_options select Configure network auto

# Static network configuration.
#
# IPv4 example
#d-i netcfg/get_ipaddress string 192.168.1.42
#d-i netcfg/get_netmask string 255.255.255.0
#d-i netcfg/get_gateway string 192.168.1.1
#d-i netcfg/get_nameservers string 192.168.1.1
#d-i netcfg/confirm_static boolean true
#
# IPv6 example
#d-i netcfg/get_ipaddress string fc00::2
#d-i netcfg/get_netmask string ffff:ffff:ffff:ffff::
#d-i netcfg/get_gateway string fc00::1
#d-i netcfg/get_nameservers string fc00::1
#d-i netcfg/confirm_static boolean true

# Any hostname and domain names assigned from dhcp take precedence over
# values set here. However, setting the values still prevents the questions
# from being shown, even if values come from dhcp.
#
# Comment to be asked during install
#d-i netcfg/get_hostname string x240
#d-i netcfg/get_domain string unassigned-domain

# If you want to force a hostname, regardless of what either the DHCP
# server returns or what the reverse DNS entry for the IP is, uncomment
# and adjust the following line.
#d-i netcfg/hostname string somehost

# Disable that annoying WEP key dialog.
d-i netcfg/wireless_wep string
# The wacky dhcp hostname that some ISPs use as a password of sorts.
#d-i netcfg/dhcp_hostname string radish

# If non-free firmware is needed for the network or other hardware, you can
# configure the installer to always try to load it, without prompting. Or
# change to false to disable asking.
d-i hw-detect/load_firmware boolean false

### Network console
# Use the following settings if you wish to make use of the network-console
# component for remote installation over SSH. This only makes sense if you
# intend to perform the remainder of the installation manually.
#d-i anna/choose_modules string network-console
#d-i network-console/authorized_keys_url string http://10.0.0.1/openssh-key
#d-i network-console/password password r00tme
#d-i network-console/password-again password r00tme

### Mirror settings
# If you select ftp, the mirror/country string does not need to be set.
#d-i mirror/protocol string http
d-i mirror/country string fr
d-i mirror/http/hostname string cdn.debian.net
d-i mirror/http/directory string /debian
d-i mirror/http/proxy string
# Suite to install.
d-i mirror/suite string sid
# Suite to use for loading installer components (optional).
d-i mirror/udeb/suite string sid

### Account setup
# Skip creation of a root account (normal user account will be able to
# use sudo).
#d-i passwd/root-login boolean false
d-i passwd/root-login boolean true
# Alternatively, to skip creation of a normal user account.
#d-i passwd/make-user boolean false
d-i passwd/make-user boolean true

# Root password, either in clear text
d-i passwd/root-password password 1234
d-i passwd/root-password-again password 1234
# or encrypted using a crypt(3)  hash.
#d-i passwd/root-password-crypted password [crypt(3) hash]

# To create a normal user account.
d-i passwd/user-fullname jdesch
d-i passwd/username string jdesch
# Normal user's password, either in clear text
d-i passwd/user-password password 1234
d-i passwd/user-password-again password 1234
# or encrypted using a crypt(3) hash.
#d-i passwd/user-password-crypted password [crypt(3) hash]
# Create the first user with the specified UID instead of the default.
#d-i passwd/user-uid string 1010

# The user account will be added to some standard initial groups. To
# override that, use this.
#d-i passwd/user-default-groups string audio cdrom video

### Clock and time zone setup
# Controls whether or not the hardware clock is set to UTC.
d-i clock-setup/utc boolean true

# You may set this to any valid setting for $TZ; see the contents of
# /usr/share/zoneinfo/ for valid values.
d-i time/zone string Europe/Paris

# Controls whether to use NTP to set the clock during the install
d-i clock-setup/ntp boolean true
# NTP server to use. The default is almost always fine here.
#d-i clock-setup/ntp-server string ntp.example.com

### Partitioning
## Partitioning example
# If the system has free space you can choose to only partition that space.
# This is only honoured if partman-auto/method (below) is not set.
d-i partman-auto/init_automatically_partition select biggest_free

# Alternatively, you may specify a disk to partition. If the system has only
# one disk the installer will default to using that, but otherwise the device
# name must be given in traditional, non-devfs format (so e.g. /dev/sda
# and not e.g. /dev/discs/disc0/disc).
# For example, to use the first SCSI/SATA hard disk:
#d-i partman-auto/disk string /dev/sda
# In addition, you'll need to specify the method to use.
# The presently available methods are:
# - regular: use the usual partition types for your architecture
# - lvm:     use LVM to partition the disk
# - crypto:  use LVM within an encrypted partition
d-i partman-auto/method string crypto

# Create volume group
#d-i partman-auto-lvm/new_vg_name string vgroup01

# You can define the amount of space that will be used for the LVM volume
# group. It can either be a size with its unit (eg. 20 GB), a percentage of
# free space or the 'max' keyword.
#d-i partman-auto-lvm/guided_size string max

# If one of the disks that are going to be automatically partitioned
# contains an old LVM configuration, the user will normally receive a
# warning. This can be preseeded away...
#d-i partman-lvm/device_remove_lvm boolean true
# The same applies to pre-existing software RAID array:
#d-i partman-md/device_remove_md boolean true
# And the same goes for the confirmation to write the lvm partitions.
#d-i partman-lvm/confirm boolean true
#d-i partman-lvm/confirm_nooverwrite boolean true

# true if will reside on lvm
#d-i partman-auto-lvm/no_boot boolean false
# true if there is no swap specified
#d-i partman-basicfilesystems/no_swap boolean false

# You can choose one of the three predefined partitioning recipes:
# - atomic: all files in one partition
# - home:   separate /home partition
# - multi:  separate /home, /var, and /tmp partitions
d-i partman-auto/multi

# Or provide a recipe of your own...
# If you have a way to get a recipe file into the d-i environment, you can
# just point at it.
#d-i partman-auto/expert_recipe_file string /hd-media/recipe

# If not, you can put an entire recipe into the preconfiguration file in one
# (logical) line. This example creates a small /boot partition, suitable
# swap, and uses the rest of the space for the root partition:
#d-i partman-auto/expert_recipe string                         \
#      home-encrypted-128G ::                                  \
#             1 1 1 free                                      \
#                    $bios_boot{ }                           \
#                   method{ biosgrub }                      \
#              .                                               \
#             256 256 256 fat32                               \
#                    $primary{ }                             \
#                   method{ efi } format{ }                 \
#          .                                               \
#         512 512 512 ext2                                \
#               $primary{ } $bootable{ }                \
#               method{ format } format{ }              \
#              use_filesystem{ } filesystem{ ext2 }    \
#             mountpoint{ /boot }                     \
#    .                                               \
#   25600 25600 25600 ext4                          \
#          $defaultignore{ } $lvmok{ }             \
#         lv_name{ lvolume_root }                 \
#                      method{ format } format{ }              \
#                     use_filesystem{ } filesystem{ ext4 }    \
#                    mountpoint{ / }                         \
#           .                                               \
#          81920 81920 -1 ext4                             \
#                 $defaultignore{ } $lvmok{ }             \
#                in_vg { crypt }                         \
#               lv_name{ lvolume_home }                 \
#              method{ format } format{ }              \
#             use_filesystem{ } filesystem{ ext4 }    \
#            mountpoint{ /home }                     \
#   .                                               \
#  1024 1024 1024 linux-swap                       \
#         $defaultignore{ } $lvmok{ }             \
#        in_vg { crypt }                         \
#       lv_name{ lvolume_swap }                 \
#      method{ swap } format{ }                \
#             .                                               \
#
#d-i partman-auto/expert_recipe string                         \
#      home-encrypted-256G ::                                  \
#              1 1 1 free                                      \
#                      $bios_boot{ }                           \
#                      method{ biosgrub }                      \
#              .                                               \
#              256 256 256 fat32                               \
#                      $primary{ }                             \
#                      method{ efi } format{ }                 \
#              .                                               \
#              512 512 512 ext2                                \
#                      $primary{ } $bootable{ }                \
#                      method{ format } format{ }              \
#                      use_filesystem{ } filesystem{ ext2 }    \
#                      mountpoint{ /boot }                     \
#              .                                               \
#              51200 51200 51200 ext4                          \
#                      $defaultignore{ } $lvmok{ }             \
#                      lv_name{ lvolume_root }                 \
#                      method{ format } format{ }              \
#                      use_filesystem{ } filesystem{ ext4 }    \
#                      mountpoint{ / }                         \
#              .                                               \
#              184320 184320 184320 ext4                       \
#                      $defaultignore{ } $lvmok{ }             \
#                      in_vg { crypt }                         \
#                      lv_name{ lvolume_home }                 \
#                      method{ format } format{ }              \
#                      use_filesystem{ } filesystem{ ext4 }    \
#                      mountpoint{ /home }                     \
#              .                                               \
#              1024 1024 1024 linux-swap                       \
#                      $defaultignore{ } $lvmok{ }             \
#                      in_vg { crypt }                         \
#                      lv_name{ lvolume_swap }                 \
#                      method{ swap } format{ }                \
#              .                                               \
#              1 2 -1 ext4                                     \
#                     $defaultignore{ } $lvmok{ }              \
#                     method{ format } lv_name{ todelete }     \
#              .

# Last partition within LVM in preseed always gets all remaining space, which was left unallocated
# If we want to left remaining space unallocated, we first create placeholder parititon todelete
# And delete it afterwards installation
#d-i preseed/late_command string lvremove -f /dev/mapper/vgroup01-todelete
# do not fail when partition does not have mnt point
d-i partman-basicmethods/method_only boolean false

# The full recipe format is documented in the file partman-auto-recipe.txt
# included in the 'debian-installer' package or available from D-I source
# repository. This also documents how to specify settings such as file
# system labels, volume group names and which physical devices to include
# in a volume group.

# This makes partman automatically partition without confirmation, provided
# that you told it what to do using one of the methods above.
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

# When disk encryption is enabled, skip wiping the partitions beforehand.
d-i partman-auto-crypto/erase_disks boolean false

## Controlling how partitions are mounted
# The default is to mount by UUID, but you can also choose "traditional" to
# use traditional device names, or "label" to try filesystem labels before
# falling back to UUIDs.
d-i partman/mount_style select traditional

### Base system installation
# Configure APT to not install recommended packages by default. Use of this
# option can result in an incomplete system and should only be used by very
# experienced users.
d-i base-installer/install-recommends boolean false

# The kernel image (meta) package to be installed; "none" can be used if no
# kernel is to be installed.
#d-i base-installer/kernel/image string linux-image-686

### Apt setup
# You can choose to install non-free and contrib software.
d-i apt-setup/non-free boolean true
d-i apt-setup/contrib boolean true
# Uncomment this if you don't want to use a network mirror.
d-i apt-setup/use_mirror boolean true
# Select which update services to use; define the mirrors to be used.
# Values shown below are the normal defaults.
d-i apt-setup/services-select multiselect security, updates
d-i apt-setup/security_host string security.debian.org

# Additional repositories, local[0-9] available
#d-i apt-setup/local0/repository string \
#       http://local.server/debian stable main
#d-i apt-setup/local0/comment string local server
# Enable deb-src lines
#d-i apt-setup/local0/source boolean true
# URL to the public key of the local repository; you must provide a key or
# apt will complain about the unauthenticated repository and so the
# sources.list line will be left commented out
#d-i apt-setup/local0/key string http://local.server/key

# By default the installer requires that repositories be authenticated
# using a known gpg key. This setting can be used to disable that
# authentication. Warning: Insecure, not recommended.
d-i debian-installer/allow_unauthenticated boolean false

# Uncomment this to add multiarch configuration for i386
#d-i apt-setup/multiarch string i386

### Package selection
tasksel tasksel/first multiselect minimal

# Individual additional packages to install
d-i pkgsel/include string
#d-i pkgsel/include string openssh-server sudo ssh ca-certificates curl git vim rsync firmware-iwlwifi
# Whether to upgrade packages after debootstrap.
# Allowed values: none, safe-upgrade, full-upgrade
d-i pkgsel/upgrade select full-upgrade

# Some versions of the installer can report back on what software you have
# installed, and what software you use. The default is not to report back,
# but sending reports helps the project determine what software is most
# popular and include it on CDs.
popularity-contest popularity-contest/participate boolean false

### Boot loader installation
# Grub is the default boot loader (for x86). If you want lilo installed
# instead, uncomment this:
#d-i grub-installer/skip boolean true
d-i grub-installer/skip boolean false
# To also skip installing lilo, and install no bootloader, uncomment this
# too:
#d-i lilo-installer/skip boolean true

# This is fairly safe to set, it makes grub install automatically to the MBR
# if no other operating system is detected on the machine.
d-i grub-installer/only_debian boolean true

# This one makes grub-installer install to the MBR if it also finds some other
# OS, which is less safe as it might not be able to boot that other OS.
#d-i grub-installer/with_other_os boolean false

# Due notably to potential USB sticks, the location of the MBR can not be
# determined safely in general, so this needs to be specified:
#d-i grub-installer/bootdev  string /dev/sda
# To install to the first device (assuming it is not a USB stick):
d-i grub-installer/bootdev  string default

# Alternatively, if you want to install to a location other than the mbr,
# uncomment and edit these lines:
#d-i grub-installer/only_debian boolean false
#d-i grub-installer/with_other_os boolean false
#d-i grub-installer/bootdev  string (hd0,1)
# To install grub to multiple disks:
#d-i grub-installer/bootdev  string (hd0,1) (hd1,1) (hd2,1)

# Optional password for grub, either in clear text
#d-i grub-installer/password password 
#d-i grub-installer/password-again password 
# or encrypted using an MD5 hash, see grub-md5-crypt(8).
#d-i grub-installer/password-crypted password [MD5 hash]

# Use the following option to add additional boot parameters for the
# installed system (if supported by the bootloader installer).
# Note: options passed to the installer will be added automatically.
#d-i debian-installer/add-kernel-opts string nousb

### Finishing up the installation
# During installations from serial console, the regular virtual consoles
# (VT1-VT6) are normally disabled in /etc/inittab. Uncomment the next
# line to prevent this.
d-i finish-install/keep-consoles boolean true

# Avoid that last message about the install being complete.
d-i finish-install/reboot_in_progress note

# This will prevent the installer from ejecting the CD during the reboot,
# which is useful in some situations.
#d-i cdrom-detect/eject boolean false

# This is how to make the installer shutdown when finished, but not
# reboot into the installed system.
d-i debian-installer/exit/halt boolean false
# This will power off the machine instead of just halting it.
d-i debian-installer/exit/poweroff boolean true

### Preseeding other packages
# Depending on what software you choose to install, or if things go wrong
# during the installation process, it's possible that other questions may
# be asked. You can preseed those too, of course. To get a list of every
# possible question that could be asked during an install, do an
# installation, and then run these commands:
#   debconf-get-selections --installer > file
#   debconf-get-selections >> file

#### Advanced options
### Running custom commands during the installation
# d-i preseeding is inherently not secure. Nothing in the installer checks
# for attempts at buffer overflows or other exploits of the values of a
# preconfiguration file like this one. Only use preconfiguration files from
# trusted locations! To drive that home, and because it's generally useful,
# here's a way to run any shell command you'd like inside the installer,
# automatically.

# This first command is run as early as possible, just after
# preseeding is read.
#d-i preseed/early_command string anna-install some-udeb
# This command is run immediately before the partitioner starts. It may be
# useful to apply dynamic partitioner preseeding that depends on the state
# of the disks (which may not be visible when preseed/early_command runs).
#d-i partman/early_command \
#       string debconf-set partman-auto/disk "$(list-devices disk | head -n1)"
# This command is run just before the install finishes, but when there is
# still a usable /target directory. You can chroot to /target and use it
# directly, or use the apt-install and in-target commands to easily install
# packages and run commands in the target system.
#d-i preseed/late_command string apt-install zsh; in-target chsh -s /bin/zsh

d-i preseed/late_command string \
in-target apt-get update; \
in-target apt-get -y upgrade; \
in-target sudo apt install -y apache2 apache2-doc php php-pdo php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath mariadb-server
