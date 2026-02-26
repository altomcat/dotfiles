(define-module (guix-config packages base))

(define-public %my-base-pkgs
  (list "glibc-locales"
        "nss-certs"
        "fastfetch"
        "vim"
        "git"
        "gnupg"
        "curl"
        "direnv"
        "shellcheck"))
