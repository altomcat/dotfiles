(define-module (guix-config systems exegol)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu services guix)
  #:use-module (gnu system setuid)
  #:use-module (gnu system locale)
  ;; #:use-module (gnu services sddm)
  ;; #:use-module (gnu services sysctl)
  #:use-module (guix)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (guix-config home home-config)
  #:use-module (guix-config tools helper)
  ;; #:use-module (guix-config services podman)
  #:use-module (guix-config systems base-system)
  #:export (exegol-operating-system))


(define user-name "li3n")

(use-service-modules linux
                     dbus
                     virtualization
                     docker
                     desktop
                     networking
                     ssh
                     spice
                     sddm
                     xorg
                     syncthing
                     security-token)

(use-package-modules display-managers
                     gnome
                     emacs
                     vpn
                     virtualization
                     spice
                     wm
                     bash
                     firmware
                     security-token)

(define-public exegol-operating-system
  (operating-system
   ;;(inherit base-system)
   (host-name "exegol")

   ;; (kernel linux)
   ;; (kernel-arguments
   ;;  (cons* "video=1920x760"
   ;;         "pcspkr.blacklist=1"
   ;;         %default-kernel-arguments))

   ;; ;; (initrd microcode-initrd)
   ;; ;; (initrd-modules (append (list "ahci")
   ;; ;;     		    %base-initrd-modules))

   ;; (firmware (cons* linux-firmware
   ;;     	     %base-firmware))

   (keyboard-layout (keyboard-layout "fr" "latin9"))

   ;; User account
   (users (cons* (user-account
                  (name user-name)
                  (group "users")
                  (home-directory (string-append "/home/" user-name))
                  (supplementary-groups '("wheel"
					  "netdev"
					  "kvm"
					  "tty"
					  "input"
					  "docker"
					  "audio"
					  "video"
                                          "libvirt")))
                 %base-user-accounts))

   (packages
    (append
     (map specification->package
          '("sway"
            "ntfs-3g"
            "exfat-utils"
            "fuse-exfat"
            "xterm"
            "pulseaudio"
            "gvfs"
            "wireguard-tools"
            "vim"
            "emacs"
            ;;             "chili-sddm-theme"
            "ovmf-x86-64"))
     %base-packages))

   (services
    (append (list (service containerd-service-type)
	          (service docker-service-type)
                  ;;(my-podman-service user-name)

                  (service openssh-service-type)
                  (service bluetooth-service-type)
                  (service gnome-desktop-service-type)
                  ;;(service colord-service-type)
                  ;; (service sddm-service-type
	          ;;          (sddm-configuration
	          ;;           (sddm sddm-qt5)
	          ;;           (theme "chili")
	          ;;           (remember-last-user? #t)
	          ;;           ))
                  (service libvirt-service-type
                           (libvirt-configuration
	                    (unix-sock-group "libvirt")
	                    (tls-port "16555")))
                  (service spice-vdagent-service-type)

                  (service virtlog-service-type)
                  (simple-service 'wireguard-module
                                  kernel-module-loader-service-type
                                  '("wireguard"))

                  (service screen-locker-service-type
	                   (screen-locker-configuration
	                    (name "swaylock")
	                    (program (file-append swaylock "/bin/swaylock"))
	                    (using-pam? #t)
	                    (using-setuid? #f)))

                  (extra-special-file "/usr/share/OVMF/OVMF_CODE.fd"
                                      (file-append ovmf "/share/firmware/ovmf_code_x64.bin"))
                  (extra-special-file "/usr/share/OVMF/OVMF_VARS.fd"
                                      (file-append ovmf "/share/firmware/ovmf_vars_x64.bin"))
                  (extra-special-file "/usr/bin/env"
                                      (file-append coreutils "/bin/env"))
                  (extra-special-file "/usr/bin/bash"
                                      (file-append bash "/bin/bash"))
                  ;; This service doesn't create a guix-home profile yet
                  (service guix-home-service-type
                           `((,user-name ,(my-home user-name))))
                  )
            (modify-services %desktop-services
                             (delete gdm-service-type)
                             (network-manager-service-type config =>
				                           (network-manager-configuration
				                            (inherit config)
				                            (vpn-plugins (list network-manager-openvpn))))
                             ;; autologin for default user
                             (mingetty-service-type config =>
                                                    (auto-login-to-tty config "tty1" user-name))
                             ;; hardware key support
                             ;; (udev-service-type config =>
                             ;;  	          (udev-configuration
                             ;;  	           (inherit config)
                             ;;  	           (rules (cons libu2f-host
                             ;;  		                (udev-configuration-rules config)))))

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
              (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
						                          %default-authorized-guix-keys)))))))

   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets (list "/boot/efi"))
     (keyboard-layout keyboard-layout)))

   ;; based on Andrew Tropin's setup
   (mapped-devices
    (list (mapped-device
           (source (uuid "94338a3e-8240-4740-875a-bb2b0d4ac137"))
           (target "enc")
           (type luks-device-mapping))))
   (swap-devices
    (list
     (swap-space
      (target "/swap/swapfile")
      (dependencies (filter (file-system-mount-point-predicate "/swap")
                            file-systems)))))
   (file-systems (cons* (file-system
			 (mount-point "/boot")
                         (device (uuid "510D-94E1" 'fat32))
                         (type "vfat"))
                        (file-system
                         (mount-point "/")
                         (device "/dev/mapper/enc")
                         (type "btrfs")
                         (options "subvol=root,ssd")
                         (dependencies mapped-devices))
                        (file-system
			 (mount-point "/gnu")
                         (device "/dev/mapper/enc")
                         (type "btrfs")
                         ;; (flags '(no-atime)) ; preserve ssd
                         (options "subvol=gnu,ssd")
                         (dependencies mapped-devices))
                        (file-system
                         (mount-point "/home")
                         (device "/dev/mapper/enc")
                         (type "btrfs")
                         ;; (flags '(no-atime)) ; preserve ssd
                         (options "subvol=home,ssd")
                         (dependencies mapped-devices))
                        (file-system
                         (mount-point "/var/log")
                         (device "/dev/mapper/enc")
                         (type "btrfs")
                         ;; (flags '(no-atime)) ; preserve ssd
                         (options "subvol=log,ssd")
                         (dependencies mapped-devices))
                        (file-system
                         (mount-point "/data")
                         (device "/dev/mapper/enc")
                         (type "btrfs")
                         ;; (flags '(no-atime)) ; preserve ssd
                         (options "subvol=data,ssd")
                         (dependencies mapped-devices))
                        (file-system
                         (mount-point "/swap")
                         (device "/dev/mapper/enc")
                         (type "btrfs")
                         ;; (flags '(no-atime)) ; preserve ssd
                         (options "subvol=swap,ssd"))
                        %base-file-systems))))

exegol-operating-system
