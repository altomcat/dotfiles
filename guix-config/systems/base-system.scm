(define-module (guix-config systems base-system)
  #:use-module (gnu)
  #:use-module (gnu system locale)
  #:use-module (gnu system nss)
  #:use-module (guix))

(use-service-modules desktop networking ssh)

(define-public base-system
  (operating-system
    (host-name "base-system")
    (keyboard-layout (keyboard-layout "us" "altgr-intl"))

    (locale-definitions (list (locale-definition (name "fr_FR.utf8")
                                                 (source "fr_FR"))
                              (locale-definition (name "en_US.utf8")
                                                 (source "en_US"))))
    (timezone "Europe/Paris")

    ;; based on wsl2 setup
    (kernel hello)
    (initrd (lambda* (. rest) (plain-file "dummyinitrd" "dummyinitrd")))
    (initrd-modules '())
    (firmware '())

    ;; User account
    (users (cons (user-account
                  (name "altomcat")
                  (group "users")
                  (supplementary-groups '("wheel"
                                          "netdev"
					  "audio"
                                          "video")))
                 %base-user-accounts))

    ;; based on wsl2 setup
    (bootloader (bootloader-configuration
		 (bootloader (bootloader
			      (name 'dummybootloader)
			      (package hello)
			      (configuration-file "/dev/null")
			      (configuration-file-generator
			       (lambda* (. rest)
				 (computed-file "dummybootloader" #~(mkdir #$output))))
			      (installer #~(const #t))))))

    (file-systems (list (file-system
                          (device "/dev/sdb")
                          (mount-point "/")
                          (type "ext4")
                          (mount? #t))))

    (services (cons* (service dhcp-client-service-type)
                     (service openssh-service-type)
                     %base-services))

    ;; Allow resolution of '.local' host names with mDNS
    (name-service-switch %mdns-host-lookup-nss)))
