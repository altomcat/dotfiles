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
             ;;(gnu services docker)
             ;;(gnu services virtualization)
             ;;(gnu services spice)
	     ;;(gnu services xorg)
	     (gnu system setuid)
             (nongnu system linux-initrd))

(use-service-modules linux dbus cups virtualization docker desktop networking ssh spice xorg)
(use-package-modules emacs vpn virtualization cups spice)

(operating-system
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 ;;(kernel-arguments '("module_blacklist=pcspkr"))
 (locale "fr_FR.utf8")
 (timezone "Europe/Paris")
 (keyboard-layout (keyboard-layout "us" "intl"))
 (host-name "argiope")

 ;; The list of user accounts ('root' is implicit).
 (users (cons* (user-account
                (name "li3n")
                (comment "Li3N")
                (group "users")
                (home-directory "/home/li3n")
                (supplementary-groups '("wheel" ; sudo
                                        "netdev"
                                        "kvm"
					"tty"
					;;	"seat" ; seat management
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
			  ;;"swaybg"
			  "waybar"
			  "ntfs-3g"
			  "exfat-utils"
			  "fuse-exfat"
			  "wireguard-tools"
                          "nss-certs"))
                   %base-packages))

 ;; Below is the list of system services.  To search for available
 ;; services, run 'guix system search KEYWORD' in a terminal.

 ;; (define %my-desktop-services
 ;;   (modify-services %desktop-services
 ;; 		    (delete gdm-service-type)))
 ;; (gdm-service-type config =>
 ;;                   (gdm-configuration
 ;;                    (inherit config)
 ;;                    (wayland? #t)))
 ;; (network-manager-service-type config =>
 ;; 				  (network-manager-configuration (inherit config)
 ;; 								 (vpn-plugins (list network-manager-openvpn))))
 ;;(dbus config => (dbus-service #:services (list blueman)))
 ;; (sysctl-service-type config =>
 ;; 			 (sysctl-configuration
 ;; 			  (settings (append
 ;; 				     '(
 ;; 				       ("net.ipv6.conf.enp5s0.disable_ipv6" . "1")
 ;; 				       ;;("net.ipv6.conf.enp3s0.disable_ipv6" . "1")
 ;; 				       ("net.ipv6.conf.all.disable_ipv6" . "1")
 ;; 				       ("net.ipv6.conf.default.disable_ipv6" . "1")
 ;; 				       %default-sysctl-settings)))))))

 (services (append
	    (list
	     (service openssh-service-type)
	     ;; (service udisks-service-type)  ;; failed with dbus ?
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
	     )
	    ;; %desktop-services ))
	    (modify-services %desktop-services
			     (delete gdm-service-type)) ))


 ;; (services (append

 ;; 	    (list
 ;; 	     ;; (service gnome-desktop-service-type)
 ;;             ;; To configure OpenSSH, pass an 'openssh-configuration'
 ;;             ;; record as a second argument to 'service' below.

 ;;             ;; (set-xorg-configuration
 ;;             ;;  (xorg-configuration (keyboard-layout keyboard-layout)))
 ;;             (service openssh-service-type)
 ;; 	     (service network-manager-service-type)
 ;; 	     (service wpa-supplicant-service-type)
 ;; 	     (service ntp-service-type)
 ;;             (service bluetooth-service-type)

 ;; 	     ;; (simple-service 'wireguard-module
 ;;             ;;                 kernel-module-loader-service-type
 ;;             ;;                 '("wireguard"))

 ;; 	     ;; make sure seatd is running
 ;; 	     ;;(service seatd-service-type)

 ;; 	     (service udisks-service-type)
 ;; 	     (service upower-service-type)
 ;; 	     (service polkit-service-type)
 ;; 	     (service elogind-service-type) ;; disabled if seatd
 ;; 	     (service dbus-root-service-type)
 ;;             (service libvirt-service-type
 ;; 		      (libvirt-configuration
 ;; 		       (unix-sock-group "libvirt")
 ;; 		       (tls-port "16555")))
 ;; 	     (service virtlog-service-type))
 ;; 	    ;; (service cups-service-type
 ;;            ;;          (cups-configuration
 ;;            ;;           (web-interface? #t)
 ;;            ;;           (extensions
 ;; 	    ;; 		(list cups-filters))))
 ;; 	    (modify-services %base-services
 ;; 	     		     (delete ntp-service-type))))

 (setuid-programs
  (append
   (list (file-like->setuid-program
	  (file-append
	   (specification->package "swaylock")
	   "/bin/swaylock")))
   %setuid-programs))

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
		      %base-file-systems)))
