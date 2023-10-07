;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu)
	     (gnu services pm)
	     (gnu services linux)
	     (gnu services sysctl)
	     (gnu services dbus)
	     (gnu services networking)
	     (gnu services vpn)
	     (gnu services desktop)
	     (gnu services cups)
	     (gnu services docker)
	     (gnu services virtualization)
	     (gnu services spice)
             (gnu packages glib)
	     (gnu packages linux)
	     (gnu packages file-systems)
	     (gnu packages gnome)
	     (gnu packages version-control)
	     (gnu packages audio)
	     (gnu packages pulseaudio)
	     (gnu packages wm)
	     (gnu packages cups)
	     (gnu packages vim)
	     (gnu packages vpn)
	     (gnu packages gtk)
	     (gnu packages xorg)
	     (gnu packages mtools)
	     (gnu packages gnuzilla)
             (gnu packages emacs)
             (gnu packages certs)
	     (gnu packages web-browsers)
	     (gnu packages version-control)
	     (gnu packages virtualization)
	     (gnu packages package-management)
	     (gnu packages spice)
	     (gnu packages xdisorg)
	     (nongnu packages linux)
             (nongnu system linux-initrd)
	     )

(use-service-modules desktop
		     networking
		     ssh
		     xorg)

(use-package-modules vpn)


(define %my-desktop-services
  (modify-services %desktop-services
		   (network-manager-service-type config =>
						 (network-manager-configuration (inherit config)
										(vpn-plugins (list network-manager-openvpn))))
                   ;; (dbus config => (dbus-root-service-type
		   ;; 		    (services (list blueman))))
		   (sysctl-service-type config =>
					(sysctl-configuration
					 (settings (append '(
     							     ("net.ipv6.conf.enp0s25.disable_ipv6" . "1")
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

  (locale "fr_FR.utf8")
  (timezone "Europe/Paris")
  (keyboard-layout (keyboard-layout "us" "intl"))
  (host-name "Arrakis")
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
     (list
      git
      ntfs-3g
      exfat-utils
      fuse-exfat
      stow
      vim
      emacs
      xterm
      bluez
      bluez-alsa
      pulseaudio
      gvfs
      tlp
      wireguard-tools
      virt-manager
      python-libvirt
      xftwidth
      (specification->package "awesome")
      (specification->package "emacs")
      ;; (specification->package "emacs-exwm")
      ;; (specification->package "emacs-desktop-environment")
      ;; (specification->package "herbstluftwm")
      ;; (specification->package "nss-certs")
      nss-certs)
     %base-packages))
  ;;(kernel-loadable-modules (list wireguard-linux-compat))
  (services
   (append
    (list (service gnome-desktop-service-type)
	  (service bluetooth-service-type)
		   ;; (bluetooth-configuration
		   ;;  (auto-enable? #t)))
	  (service spice-vdagent-service-type)
	  (simple-service 'wireguard-module
                          kernel-module-loader-service-type
                          '("wireguard"))
          (service openssh-service-type)
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
          (set-xorg-configuration
           (xorg-configuration
            (keyboard-layout keyboard-layout)))
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
