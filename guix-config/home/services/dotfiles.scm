(define-module (guix-config home services dotfiles)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services dotfiles))

(define-public %my-home-dotfiles-service
  (service home-dotfiles-service-type
	   (home-dotfiles-configuration
	    (directories '("../../files")))))
