GUIX_CONFIG_PATH = ~/.dotfiles/.config/guix
ADD_SUBSTITUTES = --substitute-urls='https://ci.guix.gnu.org https://bordeaux.guix.gnu.org https://substitutes.nonguix.org'
file := caladane.scm

# TIPS: replace $eval by $info to see the expansion

iso: $(file)
	$(eval iso_file := $(shell guix time-machine -C $(GUIX_CONFIG_PATH)/channels.scm -- system  image -t iso9660 $(GUIX_CONFIG_PATH)/$(file)))

usb_stick: iso
	sudo dd if=$(iso_file) of=/dev/sdb status=progress bs=4M oflag=sync

vm:
	$$(guix system vm caladan.scm --full-boot $(ADD_SUBSTITUTES)) -m 1024 -smp 2 -nic user,model=virtio-net-pci

# env:
# 	guix time-machine -C $(GUIX_CONFIG_PATH)/channels.scm -- environment make
