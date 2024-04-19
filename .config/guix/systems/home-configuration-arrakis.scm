;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
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

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages
  (specifications->packages
   (append
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
     "ripgrep"
     "unzip"
     "p7zip"
     "curl"
     "tree"
     "gnupg"
     "pinentry"
     "pinentry-emacs"
     "fd"
     "file"
     "rmlint"				; remove duplicates
     "yt-dlp"
     "xdg-utils" ;; for xdg-open
     "xeyes" ;; to find Xwayland apps
     "mpv"
     "colord"
     "gnuplot"
     "calibre"

     ;; utils
     "lsof"
     "ntfs-3g"
     "pasystray"
     "radeon-firmware"
     "brightnessctl"
     "broadcom-bt-firmware"
     "recutils"

     ;; dev
     "git"
     "automake"
     "autoconf"
     "gcc-toolchain@12"
     "rust"
     "cmake"
     "python"
     "shellcheck"
     "fish"

     ;; guile library
     "guile-ac-d-bus"
     ;;"guile-hoot"
     ;;"guile-gi"
     "guile-chickadee"
     
     ;; webrowser
     "ungoogled-chromium-wayland"
     "icecat"

     ;; themes
     "hicolor-icon-theme"
     "adwaita-icon-theme" ;; for virt-manager icons
     "matcha-theme"
     "papirus-icon-theme"

     ;; Virtualization
     "virt-manager"
     "libvirt"
     "python-libvirt"
     "bridge-utils"
     "dconf" ;; store connections for virt-manager
     "qemu"

     "gnome-tweaks"
     "gnome-themes-extra"
     "volumeicon"
     "mpv"
     "pavucontrol"

     ;; torrent
     "transmission"
     "transmission-remote-gtk"

     ;; misceallenous apps
     "gnome-bluetooth"
     "adwaita-icon-theme"
     "xdot"
     "peek"				; screencast
     "graphviz"
     "sxiv"
     "gnome-shell-extensions"
     "scrot"
     "xftwidth"
     "xsetroot"
     "xhost"
     "xwininfo"
     "setxkbmap"
     "xmodmap"

     ;; locales
     "glibc-locales"

     ;; libraries
     "ffmpeg"
     "libpng"
     "zstd"
     "gtk+:bin"
     "gtk+"

     ;; mpd server/client
     "mpd"
     "mpd-mpc" ;; mpc used by ncmpcpp to send notification
     "ncmpcpp"
     "cli-visualizer" ;; aka vis

     ;; ASCII's art stuff
     "cmatrix"
     "neofetch"
     "htop"
     "btop")
    %my-sway-pkgs
    %my-emacs-pkgs)))

 ;; Below Is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list (service home-bash-service-type
                 (home-bash-configuration
                  (guix-defaults? #f)                  
		  (bashrc (list (local-file
				 "/home/altomcat/guix-config/.bashrc"
				 "bashrc")
				(mixed-text-file "neofetch" "$(command -v neofetch && neofetch)")))
		  (bash-profile (list (local-file
				       "/home/altomcat/guix-config/.bash_profile"
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
