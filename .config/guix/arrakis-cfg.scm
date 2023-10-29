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

(use-service-modules linux dbus cups virtualization docker desktop networking ssh spice xorg)
(use-package-modules gnome emacs vpn virtualization cups spice wm)


(define %my-desktop-services
  (modify-services %desktop-services
		   (delete gdm-service-type)
		   ;; (gdm-service-type config =>
		   ;; 		     (wayland? #t))
		   (network-manager-service-type config =>
						 (network-manager-configuration (inherit config)
										(vpn-plugins (list network-manager-openvpn))))
                   ;; (dbus config => (dbus-root-service-type
		   ;; 		    (services (list blueman))))
                   (sysctl-service-type config =>
					(sysctl-configuration
					 (settings (append '(("net.ipv6.conf.enp0s25.disable_ipv6" . "1")
							     ("net.ipv6.conf.enp3s0.disable_ipv6" . "1")
							     ("net.ipv6.conf.all.disable_ipv6" . "1")
							     ("net.ipv6.conf.default.disable_ipv6" . "1"))
							   %default-sysctl-settings))))))
(operating-system
 ;; Use non-free Linux and firmware
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (cons* radeon-firmware
		  broadcom-bt-firmware
		  linux-firmware
  		  %base-firmware))
 (kernel-arguments
  ;; (cons "video=1920x1200@59.973" %default-kernel-arguments)
  (cons "video=3440x1440@50" %default-kernel-arguments))
 (locale "fr_FR.utf8")
 (timezone "Europe/Paris")
 (keyboard-layout (keyboard-layout "us" "intl"))
 (host-name "arrakis")

 (locale-definitions  (list (locale-definition
			     (name "en_US.utf8")
			     (source "en_US"))

			    (locale-definition
			     (name "fr_FR.utf8")
			     (source "fr_FR"))))

 (users (cons* (user-account
                (name "altomcat")
                (comment "Arnaud Lechevallier")
                (group "users")
                (home-directory "/home/altomcat")
                (supplementary-groups
                 '("wheel"
		   "netdev"
                   "kvm"       ;;  from DW config
                   "tty"       ;;  from DW config
                   "input"     ;;  from DW config
                   ;;"docker"    ;;  from DW config
                   ;;"realtime"  ;;  from DW config
		   "audio"
		   "video"
		   "lp"         ;; "lp to let user configure the device"
		   "libvirt")))
               %base-user-accounts))
 (packages
  (append
   (map specification->package
	'("git"
	  "sway"
	  "swaylock"
	  "swayhide"
	  "waybar"
	  "wlr-randr"
	  "ntfs-3g"
	  "exfat-utils"
	  "fuse-exfat"
	  "emacs"
	  "xterm"
	  "bluez"
	  "bluez-alsa"
	  "pulseaudio"
	  "gvfs"
	  "tlp"
	  "wireguard-tools"
	  "virt-manager"
	  "xftwidth"
	  "chili-sddm-theme"
	  "nss-certs"))
   %base-packages))

 ;;(kernel-loadable-modules (list wireguard-linux-compat))
 (services
  (append
   (list
    (service openssh-service-type)
    (service bluetooth-service-type)
    (service gnome-desktop-service-type)
    (service sddm-service-type
	     (sddm-configuration
	      (theme "chili")
	      (display-server "wayland")
	      (remember-last-user? #t)
	      ))
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
    (service spice-vdagent-service-type)
    (service screen-locker-service-type
	     (screen-locker-configuration
	      (name "swaylock")
	      (program (file-append swaylock "/bin/swaylock"))
	      (using-pam? #t)
	      (using-setuid? #f)))
    ;; (set-xorg-configuration
    ;;  (xorg-configuration
    ;;   (keyboard-layout keyboard-layout)))
    )
   %my-desktop-services))

 (bootloader
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (targets (list "/boot/efi"))
   (keyboard-layout keyboard-layout)))
 (swap-devices
  (list
   (swap-space
    (target (uuid "94d6d8e8-6de7-42bb-b3c6-ffaff76053d2")))))
 (file-systems
  (cons* (file-system
          (mount-point "/boot/efi")
          (device (uuid "1C1D-53CE" 'fat32))
          (type "vfat"))
         (file-system
          (mount-point "/")
          (device
           (uuid "a94722e5-5b7d-4f5e-b678-296085c800aa"
                 'ext4))
          (type "ext4"))
         (file-system
          (mount-point "/home")
          (device
           (uuid "500a431d-816d-4272-a822-ffb06bba0daa"
                 'ext4))
          (type "ext4"))
         %base-file-systems))

 ;; Allow resolution of '.local' host names with mDNS
 (name-service-switch %mdns-host-lookup-nss))
