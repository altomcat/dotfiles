(define-module (wsl)
  #:use-module (gnu)
  #:use-module (gnu services ssh)
  #:use-module (gnu services networking)
  #:use-module (gnu packages version-control)
  #:use-module (gnu system locale)
  #:use-module (guix channels)
  #:use-module (guix packages)
  #:use-module (guix profiles)
  #:use-module (ice-9 pretty-print)
  #:use-module (srfi srfi-1))

(define-public wsl-operating-system
  (operating-system
   (host-name "alcline")
   (keyboard-layout (keyboard-layout "us" "altgr-intl"))
   (locale "en_US.utf8")
   (timezone "Europe/Paris")

   (locale-definitions (list (locale-definition (name "fr_FR.utf8")
						(source "fr_FR"))
                             (locale-definition (name "en_US.utf8")
						(source "en_US"))))
   ;; User account
   (users (cons (user-account
                 (name "a066501")
                 (group "users")
                 (home-directory "/home/a066501")
                 (supplementary-groups '("wheel")))
                %base-user-accounts))

   (kernel hello)
   (initrd (lambda* (. rest) (plain-file "dummyinitrd" "dummyinitrd")))
   (initrd-modules '())
   (firmware '())

   (bootloader
    (bootloader-configuration
     (bootloader
      (bootloader
       (name 'dummybootloader)
       (package hello)
       (configuration-file "/dev/null")
       (configuration-file-generator (lambda* (. rest) (computed-file "dummybootloader" #~(mkdir #$output))))
       (installer #~(const #t))))))

   (file-systems (list (file-system
                        (device "/dev/sdb")
                        (mount-point "/")
                        (type "ext4")
                        (mount? #t))))

   (services (list (service guix-service-type)
                   (service special-files-service-type
                            `(("/usr/bin/env" ,(file-append coreutils "/bin/env"))))))))
wsl-operating-system
