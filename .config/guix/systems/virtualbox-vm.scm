;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu))
(use-service-modules desktop networking ssh xorg)

(operating-system
  (locale "en_US.utf8")
  (timezone "Europe/Paris")
  (keyboard-layout
    (keyboard-layout "us" "alt-intl"))
  (host-name "guix-vm")
  (users (cons* (user-account
                  (name "altomcat")
                  (comment "altomcat")
                  (group "users")
                  (home-directory "/home/altomcat")
                  (supplementary-groups
                    '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
  (packages
    (append
      (list (specification->package "awesome")
            (specification->package "alacritty") 
	    ;;(specification->package "qtile")
            ;;(specification->package "herbstluftwm")
            (specification->package "nss-certs"))
      %base-packages))
;;  (services %desktop-services)
  (services
    (append
      (list (service gnome-desktop-service-type)
            (set-xorg-configuration
              (xorg-configuration
                (keyboard-layout keyboard-layout))))
      %desktop-services))
  (bootloader
    (bootloader-configuration
      (bootloader grub-bootloader)
      (target "/dev/sda")
      (keyboard-layout keyboard-layout)))
  (mapped-devices
    (list (mapped-device
            (source
              (uuid "a9b7c092-9aaa-4c99-8008-63729b00ae23"))
            (target "cryptroot")
            (type luks-device-mapping))
          (mapped-device
            (source
              (uuid "a3ef4710-70e3-4726-816a-0e5f2e179da9"))
            (target "crypthome")
            (type luks-device-mapping))))
 (file-systems
    (cons* (file-system
             (mount-point "/")
             (device "/dev/mapper/cryptroot")
             (type "ext4")
             (dependencies mapped-devices))
           (file-system
             (mount-point "/home")
             (device "/dev/mapper/crypthome")
             (type "ext4")
             (dependencies mapped-devices))
           %base-file-systems)))

