(define-module (guix-config packages apps))

(define %my-apps-pkgs
  (list
   ;; webrowser
   "ungoogled-chromium-wayland"
   "icecat"
   "google-chrome-stable"

   ;; torrent
   "transmission"
   "transmission-remote-gtk"

   ;;audio/video
   "mpv"
   "volumeicon"
   "pavucontrol"

   ;; mpd server/client
   "mpd"
   "mpd-mpc" ;; mpc used by ncmpcpp to send notification
   "ncmpcpp"
   "cli-visualizer" ;; aka vis

   ;; ebooks
   "calibre"

   ;; ASCII's art stuff
   "cmatrix"
   ;;"neofetch"
   "fastfetch"
   "htop"
   "btop"

   ;; terminal
   ;;"fish"

   ;; Screencast / Screencopy
   "peek" ; screencast
   "sxiv" ; image viewer
   "scrot" ))
