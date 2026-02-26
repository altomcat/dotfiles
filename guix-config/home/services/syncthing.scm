(define-module (guix-config home services syncthing)
  ;;  #:use-module (gnu services)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services syncthing)
  #:export (%my-home-syncthing-service))

(define %my-home-syncthing-service
  (service home-syncthing-service-type
	   (for-home
	    (syncthing-configuration (logflags 5)))))
