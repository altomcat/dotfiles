GUIX_CONFIG_PATH = ~/.dotfiles/.config/guix
file := caladane.scm

# TIPS:
# replace $eval by $info to see the expansion

iso: $(file)
	$(eval iso_file := $(shell guix time-machine -C $(GUIX_CONFIG_PATH)/channels.scm -- system  image -t iso9660 $(GUIX_CONFIG_PATH)/$(file)))

usb_stick: iso
	sudo dd if=$(iso_file) of=/dev/sdb status=progress bs=4M oflag=sync

vm:
	$(guix system vm caladan.scm --full-boot) -m 1024 -smp 2 -nic user,model=virtio-net-pci

# env:
# 	guix time-machine -C $(GUIX_CONFIG_PATH)/channels.scm -- environment make
