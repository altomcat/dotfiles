;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu)
             (gnu system)
             (gnu system locale)
             (gnu system setuid)
             (gnu services sysctl)
             (gnu services sddm)
             (nongnu packages linux)
             (nongnu system linux-initrd))

(use-service-modules linux
                     dbus
                     cups
                     virtualization
                     docker
                     desktop
                     networking
                     ssh
                     spice
                     xorg
		     syncthing
		     security-token)
(use-package-modules gnome
                     emacs
                     vpn
                     virtualization
                     cups
                     spice
                     wm
		     security-token)

(define %my-desktop-services
  (modify-services %desktop-services
		   ;;(delete gdm-service-type)
		   (gdm-service-type config =>
				     (gdm-configuration
				      (inherit config)
				      (wayland? #t)))
		   ;; hardware key support
		   (udev-service-type config =>
				      (udev-configuration
				       (inherit config)
				       (rules (cons libu2f-host
						    (udev-configuration-rules config)))))
		   (network-manager-service-type config =>
						 (network-manager-configuration (inherit
										 config)
										(vpn-plugins (list
											      network-manager-openvpn))))
		   ;; Authorize substitute from nonguix channel
		   (guix-service-type config =>
				      (guix-configuration
				       (inherit config)
                                       (substitute-urls (append (list
                                                                 "https://substitutes.nonguix.org")
								%default-substitute-urls))
                                       (authorized-keys (append (list (plain-file
                                                                       "non-guix.pub" "
(public-key (ecc
              (curve Ed25519)
              (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"	))
								%default-authorized-guix-keys))))
		   
		   ))
(operating-system
 ;; Use non-free Linux and firmware
 (kernel linux)
 
 ;; non-free Intel wifi driver
 (firmware (cons iwlwifi-firmware %base-firmware))

 (kernel-arguments (cons* "video=1920x1080@60" %default-kernel-arguments))
 (locale "en_US.utf8")
 (timezone "Europe/Paris")

 (locale-definitions (list (locale-definition (name "fr_FR.utf8")
                                              (source "fr_FR"))
                           (locale-definition (name "en_US.utf8")
                                              (source "en_US"))))
 
 (keyboard-layout (keyboard-layout "fr" "latin9"))
 ;; (keyboard-layout (keyboard-layout "us" "intl"))
 ;; (keyboard-layout "fr,latin9" #:options '("grp:alt_shift_toggle"))
 
 (host-name "caladane")

 ;; plugdev group, udev support for hardware key
 (groups (cons
	  (user-group
	   (name "plugdev")
	   (system? #t))
	  %base-groups))
 
 (users (cons* (user-account
                (name "altomcat")
		(password (crypt "hello" "$6$abc"))
		(comment "Arnaud Lechevallier")
		(group "users")
		(home-directory "/home/altomcat")
		(supplementary-groups '("wheel" "netdev"
					"kvm"
					"tty"
					"input"
					;; "docker"
					;; "realtime"
					"audio"
					"video"
					"plugdev"
					"lp"
					"libvirt")))
	       %base-user-accounts))
 
 (packages (append (map specification->package
                        '("git"
			  "sway"
			  "alacritty"
			  "ntfs-3g"
                          "exfat-utils"
                          "fuse-exfat"
                          "xterm"
                          "pulseaudio"
                          "gvfs"
                          "tlp"
                          "wireguard-tools"
                          "chili-sddm-theme"
                          "btrfs-progs"))
		   %base-packages))

 ;; (kernel-loadable-modules (list wireguard-linux-compat))
 (services
  (append (list (service openssh-service-type)
                (service bluetooth-service-type)
                (service gnome-desktop-service-type)
                ;; (service sddm-service-type
                ;;          (sddm-configuration (theme "chili")
                ;;                              (remember-last-user? #t)))
                (service libvirt-service-type
                         (libvirt-configuration (unix-sock-group "libvirt")
                                                (tls-port "16555")))
                (service virtlog-service-type)
                (service cups-service-type
                         (cups-configuration (web-interface? #t)
                                             (extensions (list cups-filters))))
                (simple-service 'wireguard-module
                                kernel-module-loader-service-type
                                '("wireguard"))
                (service spice-vdagent-service-type)
                (service screen-locker-service-type
                         (screen-locker-configuration (name "swaylock")
                                                      (program (file-append
                                                                swaylock
                                                                "/bin/swaylock"))
                                                      (using-pam? #t)
                                                      (using-setuid? #f)))
		;; hardware key
		(service pcscd-service-type)
		(service syncthing-service-type
			 (syncthing-configuration
			  (user "altomcat")))

                (set-xorg-configuration
		 (xorg-configuration
		  (keyboard-layout keyboard-layout)))
		
		) %my-desktop-services))

 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
	      (targets '("/dev/sdb"))
              (timeout 3)
	      (keyboard-layout keyboard-layout)))
 (file-systems (cons* (file-system
                       (device (file-system-label "my-root"))
                       (mount-point "/")
                       (type "ext4"))
		      %base-file-systems))

 ;; Allow resolution of '.local' host names with mDNS
 (name-service-switch %mdns-host-lookup-nss))
