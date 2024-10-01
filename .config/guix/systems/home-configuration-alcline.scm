;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
	     (gnu home services)
	     (gnu home services shells)
             (gnu home services ssh)
             (gnu home services desktop)
	     (gnu home services shepherd)
             (gnu home services sound)
	     (gnu home services mcron)
             (gnu packages)
	     ;;(gnu packages ssh)
	     (gnu packages version-control)
	     (gnu packages xdisorg)
	     (gnu packages mail)
	     (gnu packages gnupg)
             (gnu services)
             (guix gexp))

(load "emacs.scm")
;; (load "sway.scm")
(load "fonts.scm")
;; (load "virtualization.scm")
;; (load "dev.scm")
;; (load "apps.scm")
;; (load "tools.scm")
;; (load "gnome.scm")

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages
  (specifications->packages
   (append
    (list
     "glibc-locales"
     "git"
     "gnupg"
     "pinentry-emacs"
     "curl"
     "ripgrep"
     "fd"
     "isync"
     "openssh"
     "fastfetch"
     "nss-certs"
     "notmuch"
     "direnv"

     ;; dictionary
     "aspell"
     "aspell-dict-en"
     "aspell-dict-fr"
     
     ;; themes
     "hicolor-icon-theme"
     "adwaita-icon-theme" ;; for virt-manager icons
     "matcha-theme"
     "papirus-icon-theme")

    %my-fonts-pkgs
    ;; %my-virtualization-pkgs
    ;; %my-sway-pkgs
    %my-emacs-pkgs
    ;; %my-dev-pkgs
    ;; %my-apps-pkgs
    ;; %my-tools-pkgs
    ;; %my-gnome-pkgs
    )))

 ;; Below Is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list (service home-bash-service-type
                 (home-bash-configuration
                  (guix-defaults? #f)
		  (bashrc (list (local-file
				 "/home/a066501/.dotfiles/.config/guix/systems/alcline/.bashrc-alcline"
				 "bashrc")))
		  (bash-profile (list (local-file
				       "/home/a066501/.dotfiles/.config/guix/systems/alcline/.bash_profile-alcline"
				       "bash_profile")))
		  ))
	;; sync mail providers every 5mn
	;; (service home-mcron-service-type
	;; 	 (home-mcron-configuration
	;; 	  (jobs (list
	;; 		 #~(job
	;; 		    '(next-minute (range 0 60 5))
	;; 		    (string-append "export PATH=$HOME/.guix-home/profile/bin; "  #$isync "/bin/mbsync all")
	;; 		    )))))
	)))
