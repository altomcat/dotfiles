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
             (gnu packages)
	     (gnu packages xdisorg)
             (gnu services)
             (guix gexp))

(load "emacs.scm")
(load "sway.scm")
(load "fonts.scm")
(load "virtualization.scm")
(load "dev.scm")
(load "apps.scm")
(load "tools.scm")
(load "gnome.scm")

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages
  (specifications->packages
   (append
    (list
     ;; locales
     "glibc-locales"
     
     ;; themes
     "hicolor-icon-theme"
     "adwaita-icon-theme" ;; for virt-manager icons
     "matcha-theme"
     "papirus-icon-theme"
     )

    %my-fonts-pkgs
    %my-virtualization-pkgs
    %my-sway-pkgs
    %my-emacs-pkgs
    %my-dev-pkgs
    %my-apps-pkgs
    %my-tools-pkgs
    %my-gnome-pkgs
    )))

 ;; Below Is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list (service home-bash-service-type
                 (home-bash-configuration
                  (guix-defaults? #f)
		  (bashrc (list (local-file
				 "./arrakis/.bashrc-arrakis"
				 "bashrc")
				;; (mixed-text-file "direnv"
				;; 		 "$(command -v direnv > /dev/null) && eval $(direnv hook bash)")
				(mixed-text-file "fastfetch" "(command -v fastfetch) && fastfetch")))
		  (bash-profile (list (local-file
				       "./arrakis/.bash_profile-arrakis"
				       "bash_profile")))
		  (environment-variables '(("PS1" . "\\u \\wλ ")
					   ("ALTERNATE_EDITOR" . "")
					   ("EDITOR" . "emacsclient -t")
					   ("VISUAL" . "emacsclient -c -a emacs")))
		  (aliases
                   '(("youtube-dl" . "yt-dlp")))))
	(service home-dbus-service-type)
	(service home-pipewire-service-type)
	(service home-redshift-service-type
		 (home-redshift-configuration
		  (redshift redshift-wayland)
	          (adjustment-method 'wayland)
		  (location-provider 'manual)
		  (latitude 49.0)
		  (longitude 1.2)))
	)))
