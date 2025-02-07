# Overview

script to install arch linux very quickly. By default it will install a setup with no desktop environment but you can also install one easily by answering a question.

*Approximate time for install* : 2-3 minutes

Fork Edit: testing to install with separate /home partition, added to linux linux-firmware to pacstrap & changed some of the installed packages ...

# Installation

- Boot the Arch linux iso
- Get the scripts from this repo
- Launch ./install.sh from the script folder and answer the questions.

  **Example:**
  
      curl -L https://github.com/fretzo/arch_installer/archive/master.zip --output scripts.zip
      bsdtar -x -f scripts.zip
      cd arch_installer-master
      chmod +x *.sh
      ./install.sh


## Current Requirements

- EFI support
- internet connection

#### Virtualbox note requirement:
- make sure the VM is EFI enabled. (Settings -> System -> Enable EFI)


## Current Features:

- NVME drive support
- custom font for install (easier for 4k laptop)
- generate real time mirror list and let you decide easily the one that you want.
- let you choose target drive
- change password
- select timezone
- add custom users + options for username, password and sudo privilege
- change locale and keyboard layout
- configure makepkg for multi-cores
- install XFCE (Optional) + detect video drivers


#### Success

- Virtual Box VM
- Thinkpad T580 (install via LAN port)
