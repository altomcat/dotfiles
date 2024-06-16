(use-modules (gnu home)
	     ;;(gnu home services)
	     (gnu home services shells)
	     (gnu home services ssh)
             (gnu home services desktop)
             (gnu home services shepherd)
	     (gnu home services sound)
             (gnu packages)
					;(gnu packages admin)
					;(gnu packages glib)
					;(gnu packages bash)
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

;; (define %sway-launcher-service
;;   (simple-service 'sway-launcher
;;                   home-bash-service-type
;;                   (home-bash-extension
;;                    (bashrc (list (plain-file "bashrc" "\
;; export ALTERNATE_EDITOR=\"\"
;; export EDITOR=\"emacsclient -t\"
;; export VISUAL=\"emacsclient -c -a emacs\"

;; [ \"$(tty)\" = \"/dev/tty1\" ] && dbus-run-session sway"))) )))

;; (define %bash-fancy-prompt-service
;;   (simple-service 'bash-fancy-prompt
;;                   home-bash-service-type
;;                   (home-bash-extension
;;                    (environment-variables
;;                     '(("PS1" . "\\u \\wλ "))))))

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

 ;; "dconf" ;; store connections for virt-manager

 ;; ;; dev
 ;; ;;"poetry"

 ;; ;; webrowser
 ;; "vimb"
 ;; "ungoogled-chromium-wayland"

 (services
  (list (service home-bash-service-type
		 (home-bash-configuration
		  (guix-defaults? #f)
		  (bashrc (list (local-file
				 "/home/li3n/guix-config/.bashrc"
				 "bashrc")
				(mixed-text-file "neofetch" "$(command -v neofetch && neofetch)")))
		  (bash-profile (list (local-file
				       "/home/li3n/guix-config/.bash_profile"
				       "bash_profile")))
		  ;; environment variables are written in .bash_profile
		  (environment-variables '(("ALTERNATE_EDITOR" . "")
					   ("EDITOR" . "emacsclient -t")
					   ("VISUAL" . "emacsclient -c -a emacs")
					   ;; ("PS1" . "\\u \\wλ ")
					   ))
		  ;; aliases are written in .bashrc
		  (aliases
		   '(("youtube-dl" . "yt-dlp")))))

	(service home-dbus-service-type)
	(service home-pipewire-service-type)
	(service home-openssh-service-type
		 (home-openssh-configuration
		  (hosts
		   (list (openssh-host (name "Arrakis")
				       (host-name "192.168.1.7")
				       (user "altomcat"))))))
	;; %sway-launcher-service
	)))
