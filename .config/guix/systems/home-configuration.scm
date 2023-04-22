(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
	     (gnu home services ssh)
	     (gnu home services desktop)
             (gnu services)
	     (gnu packages)
             (gnu packages admin)
	     (gnu packages glib)
	     (gnu packages bash)
             (guix gexp))

(define %sway-launcher-service
  (simple-service 'sway-launcher
                  home-bash-service-type
                  (home-bash-extension
		   (bashrc (list (plain-file "bashrc" "\
export ALTERNATE_EDITOR=\"\"
export EDITOR=\"emacsclient -t\"
export VISUAL=\"emacsclient -c -a emacs\"

[ \"$(tty)\" = \"/dev/tty1\" ] && dbus-run-session sway"))) )))

(define %bash-fancy-prompt-service
  (simple-service 'bash-fancy-prompt
                  home-bash-service-type
                  (home-bash-extension
                   (environment-variables
                    '(("PS1" . "\\u \\wλ "))))))
(home-environment
 (packages (cons*
	    (list glib "bin")
	    (map specification->package
                 (list
		  ;; fonts
		  "font-iosevka-aile"
		  "font-mononoki"
		  "font-openmoji"
 		  "font-awesome"

		  ;; useful tools
		  "aspell"
		  "aspell-dict-en"
		  "aspell-dict-fr"

		  "alacritty"
		  "fuzzel"
                  "ripgrep"

		  "tree"
		  "gnupg"
	          "pinentry"
		  "pinentry-emacs"
		  "thunar"
                  "neofetch"
		  "xdg-utils" ;; for xdg-open
		  "dconf" ;; store connections for virt-manager
		  "xeyes" ;; to find Xwayland apps
                  "mpv"
		  "redshift"

		  ;; webrowser
		  "vimb"
                  "ungoogled-chromium-wayland"

		  ;; themes
		  "adwaita-icon-theme" ;; for virt-manager icons
		  "matcha-theme"
		  "papirus-icon-theme"

                  ;; sway
		  "wofi" ;; launcher apps
                  "bemenu" ;; alternative menu for sway
		  "swayidle"

		  ;; Virtualization
		  "virt-manager"
		  "virt-viewer"
                  "libvirt"
		  "python-libvirt"

		  ;; emacs
		  "emacs-next-pgtk"
                  "emacs-with-editor"  ;; need to look at this package
		  "emacs-ef-themes"

		  "emacs-js2-mode"
		  "emacs-hydra"
		  "emacs-helpful"
		  "emacs-graphviz-dot-mode"
		  "emacs-graphql"
		  "emacs-glsl-mode"
		  ;; emacs-gif-screencast
		  "emacs-geiser-guile"
		  "emacs-geiser"
		  "emacs-guix"
		  "emacs-flycheck"
		  "emacs-expand-region"
		  ;; emacs-emojify
		  "emacs-elfeed"
		  "emacs-doom-modeline"
		  "emacs-dashboard"
		  ;; emacs-csv-mode
		  ;; emacs-csv
		  ;; emacs-corfu-terminal
		  ;; emacs-corfu-doc-terminal
		  ;; emacs-corfu-doc
		  "emacs-corfu"
		  ;; emacs-consult-yasnippet
		  "emacs-consult-org-roam"
		  ;; emacs-consult-notmuch
		  "emacs-consult-lsp"
		  ;; emacs-consult-eglot
		  ;; emacs-consult-dir
		  ;; emacs-consult-bibtex
		  "emacs-consult"
		  ;; emacs-cc-mode
		  "emacs-bongo"
		  ;; emacs-all-the-icons-ibuffer
		  "emacs-all-the-icons-dired"
		  "emacs-all-the-icons-completion"
		  "emacs-all-the-icons"
		  "emacs-ace-window"
		  ;; emacs-ace-link
		  ;; emacs-ace-jump-mode
		  "emacs-websocket"
		  "emacs-simple-httpd"
		  "emacs-visual-fill-column"


		  "emacs-vertico"
		  "emacs-marginalia"
		  "emacs-embark"

		  "emacs-compat"
		  "emacs-dash"
		  "emacs-lsp-mode"
		  ))))
 (services (list
	    (service home-redshift-service-type
		     (home-redshift-configuration
		      (location-provider 'manual)
		      (latitude 49.095)    ; @Irreville
		      (longitude 1.2040)))
            ;; (service home-bash-service-type
	    ;; 	     (home-bash-configuration
	    ;; 	      (environment-variables '(("ALTERNATE_EDITOR" . "")
	    ;; 				       ("EDITOR" . "emacsclient -t")
	    ;; 				       ("VISUAL" . "emacsclient -c -a emacs"))) ))
	    (service home-openssh-service-type
		     (home-openssh-configuration
		      (hosts
		       (list (openssh-host (name "Arrakis")
					   (host-name "192.168.1.7")
					   (user "altomcat"))))))
	    %sway-launcher-service  ;; at the launcher at the end of the file ?
	    )) )
