(define-module (guix-config packages sway))

(define-public %my-sway-pkgs
  (list
   ;; sway
   "sway"
   "swayr"
   "swaylock"
   "swayhide"
   "waybar"
   "wlr-randr"
   "swaynotificationcenter";; Sway notification
   "wf-recorder" ;; Screencast recorder for sway
   ;; "kanshi" ;; replacement for arandr
   ;; "arandr"
   ;; "wofi" ;; launcher apps
   ;; "bemenu" ;; alternative menu for sway
   "swayidle"
   "wl-clipboard"
   "slurp"
   "grim"
   "swappy" ;; screenshot for sway
   "thunar"
   "thunar-volman"
   "alacritty"
   "fuzzel"
   "gucharmap" ;; view Unicode characters table
   "libnotify" ;; notify-send
   "redshift-wayland"
   "udiskie" ;; to manage usb drives
   "blueman"

   ;; default themes
   "hicolor-icon-theme"
   "adwaita-icon-theme" ;; for virt-manager icons
   "matcha-theme"
   "papirus-icon-theme"))
