;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu))
(use-service-modules desktop networking ssh xorg)

(operating-system
 (locale "en_US.utf8")
 (timezone "Europe/Paris")
 (keyboard-layout
  (keyboard-layout "us" "alt-intl"))
 (host-name "Giedi-Prime")
 (users (cons* (user-account
                (name "altomcat")
                (comment "Altomcat")
                (group "users")
                (home-directory "/home/altomcat")
                (supplementary-groups
                 '("wheel" "netdev" "audio" "video")))
               %base-user-accounts))
 (packages
  (append
   (list (specification->package "sway"))
   %base-packages))
 (services %desktop-services)
 (bootloader
  (bootloader-configuration
   (bootloader grub-bootloader)
   (target "/dev/sda")
   (keyboard-layout keyboard-layout)))
 (mapped-devices
  (list (mapped-device
         (source
          (uuid "20d4a007-a1e1-467e-9a50-26e737d0f764"))
         (target "cryptroot")
         (type luks-device-mapping))))
 (file-systems
  (cons* (file-system
          (mount-point "/")
          (device "/dev/mapper/cryptroot")
          (type "ext4")
          (dependencies mapped-devices))
         %base-file-systems)))
