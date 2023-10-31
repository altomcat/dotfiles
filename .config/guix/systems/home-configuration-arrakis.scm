;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
	     (gnu home services shells)
             (gnu home services ssh)
             (gnu home services desktop)
             (gnu packages)
	     (gnu packages xdisorg)
             (gnu services)
             (guix gexp)
             (gnu home services shells))

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages
  (specifications->packages
   (list
    ;; fonts
    "font-iosevka-comfy"
    "font-openmoji"
    "font-awesome"
    "unicode-emoji"
    "font-google-noto-emoji"

    ;; useful tools
    "aspell"
    "aspell-dict-en"
    "aspell-dict-fr"

    "alacritty"
    "fuzzel"
    "ripgrep"
    "unzip"
    "curl"
    "tree"
    "gnupg"
    "pinentry"
    "pinentry-emacs"
    "thunar"
    "thunar-volman"
    "neofetch"
    "xdg-utils" ;; for xdg-open
    "dconf" ;; store connections for virt-manager
    "xeyes" ;; to find Xwayland apps
    "mpv"
    "slurp"
    "grim"
    "swappy" ;; screenshot for sway
    "colord"

    ;; utils
    "ntfs-3g"

    ;; dev
    
    ;; webrowser
    "vimb"
    "ungoogled-chromium"
    "ungoogled-chromium-wayland"

    ;; themes
    "hicolor-icon-theme"
    "adwaita-icon-theme" ;; for virt-manager icons
    "matcha-theme"
    "papirus-icon-theme"

    ;; sway
    "wofi" ;; launcher apps
    "bemenu" ;; alternative menu for sway
    "swayidle"
    "swaynotificationcenter"
    "wl-clipboard"

    ;; Virtualization
    "virt-manager"
    "libvirt"
    "python-libvirt"

    ;; emacs
    "emacs-pgtk"
    "emacs-substitute"
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
    "emacs-magit"
    "emacs-flycheck"
    "emacs-expand-region"
    "emacs-emojify"
    "emacs-elfeed"

    "emacs-ef-themes"
    "emacs-doom-themes"
    "emacs-modus-themes"
    "emacs-doom-modeline"
    "emacs-dashboard"
    "emacs-corfu"
    "emacs-consult-org-roam"
    
    "emacs-consult"
    "emacs-bongo"
    "emacs-all-the-icons-dired"
    "emacs-all-the-icons-completion"
    "emacs-all-the-icons"
    "emacs-ace-window"
    "emacs-websocket"
    "emacs-simple-httpd"
    "emacs-visual-fill-column"

    "emacs-orderless"
    "emacs-vertico"
    "emacs-marginalia"
    "emacs-embark"

    "emacs-popper"
    
    "emacs-org"
    "emacs-org-superstar"
    "emacs-citar"
    "emacs-citar-org-roam"
    "emacs-org-fancy-priorities"
    "emacs-org-roam-ui"
    "emacs-saveplace-pdf-view"
    "emacs-pdf-tools"
    "emacs-org-noter"
    "emacs-org-appear"
    "emacs-org-tree-slide"
    "emacs-org-download"
    "emacs-org-drill"
    "emacs-toc-org"
    "emacs-org-pomodoro"
    "emacs-ox-reveal"
    "emacs-plantuml-mode"
    "emacs-org-present"
    "emacs-tablist"
    "emacs-simple-httpd"
    "emacs-sml-mode"
    "emacs-which-key"
    "emacs-perspective"
    "emacs-beacon"
    "emacs-keycast"
    "emacs-rainbow-delimiters"
    "emacs-highlight-indent-guides"
    "emacs-org-fragtog"
    "emacs-yasnippet"
    "emacs-yasnippet-snippets"
    "emacs-nov-el"
    "emacs-multiple-cursors"
    "emacs-smartparens"
    "emacs-aggressive-indent"

    "emacs-ccls"
    "emacs-dap-mode"
    "emacs-pyvenv"
    "emacs-jupyter"

    "emacs-ement"
    ;; "emacs-julia-mode"
    "emacs-julia-repl"
    "emacs-typescript-mode"
    "emacs-json-mode"
    "emacs-js2-mode"

    "emacs-lua-mode"
    "emacs-cmake-mode"
    "emacs-powershell"

    "emacs-kotlin-mode"
    "emacs-cape"
    "emacs-tempel"
    "emacs-tempel-collection"
    
    "emacs-compat"
    "emacs-transient"
    "emacs-eros"
    "emacs-shackle"
    "emacs-kind-icon"
    "emacs-org-contrib"
    "emacs-mpv"
    "emacs-aio"
    "emacs-font-lock+"
    "tree-sitter"

    "lsof"
    "gnome-tweaks"
    "qemu"
    "icecat"
    "grim"
    "swappy"
    "youtube-dl"
    "gnome-themes-extra"
    "volumeicon"
    "transmission-remote-gtk"
    "mpv"
    "ffmpeg"
    "network-manager-openvpn"
    "pavucontrol"
    "blueman"
    ;;"dunst"
    "transmission"
    "gnome-bluetooth"
    "xdot"
    "peek"
    "pasystray"
    "arandr"
    "gtk+:bin"
    "protonvpn-cli"
    "gtk+"
    "graphviz"
    "git"
    "rmlint"
    "sxiv"
    "screenfetch"
    "gnome-shell-extensions"
    "scrot"
    "xftwidth"
    "xsetroot"
    "fish"
    "python"
    "xhost"
    "unclutter"
    "xprop"
    "xev"
    "setxkbmap"
    "xmodmap"
    "neofetch"
    "gcc-toolchain@12"
    "rust"
    "cmake"
    "playerctl"
    "openvpn"
    "radeon-firmware"
    "brightnessctl"
    "adwaita-icon-theme"
    "shellcheck"
    "hlint"
    "htop"
    "libpng"
    "p7zip"
    "btop"
    "fd"
    "broadcom-bt-firmware"
    "stow"
    "unzip"
    "xwininfo"
    "guile-ac-d-bus"
    "glibc-locales"
    "automake"
    "autoconf"
    "file"
    "cmatrix"
    "zstd"
    )
   )
  )

 ;; Below Is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list (service home-bash-service-type
                 (home-bash-configuration
                  (guix-defaults? #f)
		  (bashrc (list (local-file
				 "/home/altomcat/guix-config/.bashrc"
				 "bashrc")))
		  (bash-profile (list (local-file
				       "/home/altomcat/guix-config/.bash_profile"
				       "bash_profile")))
		  (environment-variables '(("PS1" . "\\u \\wλ ")
					   ("ALTERNATE_EDITOR" . "")
					   ("EDITOR" . "emacsclient -t")
					   ("VISUAL" . "emacsclient -c -a emacs")))))
	
	(service home-redshift-service-type
		 (home-redshift-configuration
		  (location-provider 'manual)
		  (latitude 49.0)
		  (longitude 1.2)))))
 )
