;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(define-module (guix-config home home-config)
  #:use-module (guix-config home services syncthing)
  #:use-module (guix-config home services dotfiles)
  #:use-module (guix-config home services bash)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (guix-config packages base)
  #:use-module (guix-config packages emacs)
  #:use-module (guix-config packages sway)
  #:use-module (guix-config packages fonts))

(define %my-base-packages
  (specifications->packages
   (append %my-base-pkgs
          ;; %my-fonts-pkgs
          ;; %my-sway-pkgs
          ;; %my-emacs-pkgs
           ;; %my-virtualization-pkgs
           ;; %my-dev-pkgs
           ;; %my-apps-pkgs
           ;; %my-tools-pkgs
           ;; %my-gnome-pkgs
           )))

(define-public (my-home user-name)
  (format #t "username = ~a~%" user-name)
  ;;  (let ((all-packages (append (specifications->packages (list "hello")) %my-base-packages)))
  (let ((all-packages (cons* (specification->package "hello")
                             %my-base-packages)))
    (home-environment
     ;; Below is the list of packages that will show up in your
     ;; Home profile, under ~/.guix-home/profile.
     (packages all-packages)
     (services (list ;;%my-home-bash-service
                %my-home-syncthing-service
                %my-home-dotfiles-service)))))
