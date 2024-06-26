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
             (guix gexp)
             (gnu home services shells))

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
                                 ;; "/home/a066501/guix-config/.bashrc-ROSie"
				 "ROSie/.bashrc-ROSie"
				 "bashrc")
				(mixed-text-file "direnv"
						 "(command -v direnv > /dev/null) && eval \"$(direnv hook bash)\"")
				(mixed-text-file "neofetch"
						 "$(command -v neofetch && neofetch)")))
		  (bash-profile (list (local-file
                                       ;; "/home/a066501/guix-config/.bash_profile"
				       "ROSie/.bash_profile-ROSie"
				       "bash_profile")))
		  (environment-variables '(("PS1" . "\\u \\wλ ")
					   ("ALTERNATE_EDITOR" . "")
					   ("EDITOR" . "emacsclient -t")
					   ("VISUAL" . "emacsclient -c -a emacs")))
		  (aliases
                   '(("youtube-dl" . "yt-dlp")
		     ("guix-home-reconfigure" . "guix home reconfigure ~/.dotfiles/.config/guix/systems/home-configuration-ROSie.scm --substitute-urls='https://ci.guix.gnu.org https://bordeaux.guix.gnu.org https://substitutes.nonguix.org'")))))
	;; The destination file id defined with the first path that is relative to XDG_CONFIG_DIR
	;; The source file to be copied is stored at the level of the home configuration file.
	(service home-xdg-configuration-files-service-type
		 `(("sway/config" ,(local-file "ROSie/sway/config"))
		   ("waybar/config" ,(local-file "ROSie/waybar/config"))
		   ("waybar/style.css" ,(local-file "ROSie/waybar/style.css"))))
	(service home-dbus-service-type)
	;; (service home-pipewire-service-type)
	;; (service home-redshift-service-type
	;; 	 (home-redshift-configuration
	;; 	  (redshift redshift-wayland)
	;;           (adjustment-method 'wayland)
	;; 	  (location-provider 'manual)
	;; 	  (latitude 49.0)
	;; 	  (longitude 1.2)))
	)))
