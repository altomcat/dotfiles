;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
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
    "font-google-noto-emoji"

    "aspell"
    "aspell-dict-en"
    "aspell-dict-fr"
    "alacritty"
    "xrandr"
    "stow"
    "gnupg"

    ;;development
    "make"
    "git"
    
    "openssh"
    "picom"
    "nitrogen"
    "volumeicon"
    "thunar"
    "ranger"
    "slock"
    ;;"poetry"
    "qutebrowser"
    "xdg-utils"
    "mpv"
    "emacs"
    "tree-sitter"
    ;; emacs stuff
    "emacs-ace-window"
    "emacs-aggressive-indent"
    "emacs-all-the-icons"
    "emacs-all-the-icons-completion"
    "emacs-all-the-icons-dired"
    "emacs-beacon"
    "emacs-bongo"
    "emacs-cape"
    "emacs-ccls"
    "emacs-citar"
    "emacs-citar-org-roam"
    "emacs-cmake-mode"
    "emacs-consult"
    "emacs-consult-eglot"
    "emacs-consult-lsp"
    "emacs-consult-org-roam"
    "emacs-corfu"
    "emacs-dap-mode"
    "emacs-dashboard"
    "emacs-doom-modeline"
    "emacs-doom-themes"
    "emacs-ef-themes"
    "emacs-eglot"
    "emacs-eglot-tempel"
    "emacs-tempel-collection"
    "emacs-elfeed"
    "emacs-embark"
    "emacs-ement"
    "emacs-emojify"
    "emacs-eros"
    "emacs-expand-region"
    "emacs-f"
    "emacs-flycheck"
    "emacs-geiser-guile"
    "emacs-glsl-mode"
    "emacs-graphql"
    "emacs-graphviz-dot-mode"
    "emacs-guix"
    "emacs-helpful"
    "emacs-highlight-indent-guides"
    "emacs-hydra"
    "emacs-js2-mode"
    "emacs-json-mode"
    ;;"emacs-julia-mode"
    "emacs-julia-repl"
    "emacs-jupyter"
    "emacs-keycast"
    "emacs-lsp-mode"
    "emacs-lsp-treemacs"
    "emacs-lsp-ui"
    ;;"emacs-lua-mode"
    "emacs-magit"
    "emacs-marginalia"
    "emacs-modus-themes"
    "emacs-multiple-cursors"
    "emacs-nov-el"
    "emacs-ob-async"
    "emacs-orderless"
    "emacs-org-appear"
    "emacs-org-contrib"
    "emacs-org-download"
    "emacs-org-drill"
    "emacs-org-fancy-priorities"
    "emacs-org-fragtog"
    "emacs-org-noter"
    "emacs-org-pomodoro"
    "emacs-org-present"
    "emacs-org-ref"
    "emacs-org-reveal"
    "emacs-org-roam"
    "emacs-org-roam-bibtex"
    "emacs-org-roam-ui"
    "emacs-org-superstar"
    "emacs-org-tree-slide"
    "emacs-ox-pandoc"
    "emacs-ox-reveal"
    "emacs-page-break-lines"
    "emacs-pdf-tools"
    "emacs-plantuml-mode"
    "emacs-popper"
    "emacs-powershell"
    "emacs-pretty-mode"
    "emacs-project"
    "emacs-pyvenv"
    "emacs-rainbow-delimiters"
    "emacs-rainbow-identifiers"
    "emacs-rainbow-mode"
    "emacs-ripgrep"
    "emacs-saveplace-pdf-view"
    "emacs-shackle"
    "emacs-smartparens"
    "emacs-sml-mode"
    "emacs-so-long"
    "emacs-svg-icon"
    "emacs-svg-lib"
    "emacs-tablist"
    "emacs-toc-org"
    "emacs-treemacs"
    "emacs-treemacs-extra"
    "emacs-typescript-mode"
    "emacs-use-package"
    "emacs-vertico"
    "emacs-visual-fill-column"
    "emacs-which-key"
    "emacs-xref"
    "emacs-yasnippet"
    "emacs-yasnippet-snippets"
    ;;"emacs-company"
    ;;"emacs-company-box"
    ;;"emacs-company-posframe"
    ;;"emacs-dash"
    ;;"emacs-emacsql"
    ;;"emacs-emacsql-sqlite3"
    ;;"emacs-geiser"
    ;;"emacs-ox-hugo"
    ;;"emacs-poetry"
    ;;"emacs-prescient"
    ;;"emacs-simple-httpd"
    ;;"emacs-sqlite"
    ;;"emacs-transient"
    ;;"emacs-vertico-posframe"
    ;;"emacs-websocket"
    ;;"emacs-zmq"
    )))
 
 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list (service home-bash-service-type
                 (home-bash-configuration
		  (guix-defaults? #f)
                  (bashrc (list (local-file
                                 "/home/altomcat/.dotfiles/.bashrc"
                                 "bashrc")
				))
		  (bash-profile (list (local-file
				       "/home/altomcat/.dotfiles/.bash_profile"
				       "bash_profile")))
		  )))))
