;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
             (nongnu packages linux)
	     (gnu system)
             (gnu system locale)
             (gnu system setuid)
             (nongnu system linux-initrd))

(use-service-modules linux dbus cups virtualization docker desktop networking ssh spice xorg)
(use-package-modules emacs vpn virtualization cups spice wm)

(operating-system
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 (kernel-arguments
  (cons "video=1920x1200@59.973" %default-kernel-arguments))
 (locale "fr_FR.utf8")
 (timezone "Europe/Paris")
 (keyboard-layout (keyboard-layout "us" "intl"))
 (host-name "argiope")


 (locale-definitions  (list (locale-definition
			     (name "en_US.utf8")
			     (source "en_US"))
			    
			    (locale-definition
			     (name "fr_FR.utf8")
			     (source "fr_FR"))))
 
 ;; The list of user accounts ('root' is implicit).
 (users (cons* (user-account
		(name "li3n")
		(comment "Li3n")
		(group "users")
		(home-directory "/home/li3n")
		(supplementary-groups '("wheel" ; sudo
					"netdev"
					"kvm"
					"tty"
					;;       "seat" ; seat management
					"input"
					"audio" ; sound card
					"video" ; video devices
					"lp"
					"libvirt"
					)))
	       %base-user-accounts))

 ;; Packages installed system-wide.  Users can also install packages
 ;; under their own account: use 'guix search KEYWORD' to search
 ;; for packages and 'guix install PACKAGE' to install a package.
 (packages (append (map specification->package
			'("git"
                          "sway"
                          "swaylock"
                          "swayhide"
                          "emacs-next"
                          "waybar"
                          "redshift-wayland"
                          "ntfs-3g"
                          "exfat-utils"
                          "fuse-exfat"
                          "wireguard-tools"
                          "nss-certs"
			  "gvfs"))
                   %base-packages))

 (services (append
            (list
             (service openssh-service-type)
             (service bluetooth-service-type)
             (service libvirt-service-type
                      (libvirt-configuration
		       (unix-sock-group "libvirt")
		       (tls-port "16555")))
             (service virtlog-service-type)
             (service cups-service-type
                      (cups-configuration
		       (web-interface? #t)
		       (extensions
			(list cups-filters))))
             (simple-service 'wireguard-module
                             kernel-module-loader-service-type
                             '("wireguard"))
	     (service screen-locker-service-type
		      (screen-locker-configuration
		       (name "swaylock")
		       (program (file-append swaylock "/bin/swaylock"))
		       (using-pam? #t)
		       (using-setuid? #f))))
	    (modify-services %desktop-services
			     (delete gdm-service-type))))

 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets (list "/boot/efi"))
              (keyboard-layout keyboard-layout)))
 
 (mapped-devices (list (mapped-device
			(source (uuid
                                 "5fd10b6d-5b91-454f-98bf-c6a7f01a3b07"))
			(target "cryptroot")
			(type luks-device-mapping))
		       (mapped-device
			(source (uuid
                                 "feda3a26-c369-4d63-b5cb-47f1111480d0"))
			(target "cryptpool")
			(type luks-device-mapping))))

 ;; The list of file systems that get "mounted".  The unique
 ;; file system identifiers there ("UUIDs") can be obtained
 ;; by running 'blkid' in a terminal.
 (file-systems (cons* (file-system
		       (mount-point "/boot/efi")
		       (device (uuid "D04C-AD7B"
                                     'fat32))
		       (type "vfat"))
                      (file-system
		       (mount-point "/")
		       (device "/dev/mapper/cryptroot")
		       (type "ext4")
		       (dependencies mapped-devices))
                      (file-system
		       (mount-point "/poolvm")
		       (device "/dev/mapper/cryptpool")
		       (type "ext4")
		       (dependencies mapped-devices))
                      %base-file-systems))

 ;; Allow resolution of '.local' host names with mDNS
 (name-service-switch %mdns-host-lookup-nss))
