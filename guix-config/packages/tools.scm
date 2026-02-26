(define-module (guix-config packages tools))

(define-public %my-tools-pkgs
  (list
   ;; useful tools
   "unzip"
   "p7zip"
   "tree"
   "gnupg"
   "pinentry"
   "file"
   "rmlint" ; remove duplicates
   "yt-dlp"
   "xdg-utils" ; for xdg-open
   ;; "xeyes" ; to find Xwayland apps
   ;;"colord"

   ;; utils
   "lsof"
   "ntfs-3g"
   "pasystray"
   "radeon-firmware"
   "brightnessctl"
   "broadcom-bt-firmware"
   "recutils" ; provides recsel
   ))
