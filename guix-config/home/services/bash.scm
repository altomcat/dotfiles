(define-module (guix-config home services bash)
  #:use-module (gnu)
  #:use-module (guix)
  ;; #:use-module (guix gexp)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (guix-config tools helper)
  )

(define-public %my-home-bash-service
  (let ((defined-system-name (gethostname)))
    (service home-bash-service-type
             (home-bash-configuration
              (guix-defaults? #f)
              (bashrc (list (local-file
		             (string-append  ".config/guix/systems/"
			                     defined-system-name
                                             "/.bashrc-" defined-system-name)
		             "bashrc")))
              (bash-profile (list (local-file
			           (string-append ".config/guix/systems/"
				                  defined-system-name
				                  "/.bash_profile-" defined-system-name)
			           "bash_profile")))))))
