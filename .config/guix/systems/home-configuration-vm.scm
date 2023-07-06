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

    ;; emacs stuff
    "emacs-next"
    "emacs-org-appear"
    "emacs-org-roam"
    "emacs-aggressive-indent"
    "emacs-ccls"
    "emacs-ement"
    "emacs-highlight-indent-guides"
    "emacs-multiple-cursors"
    "emacs-org-fragtog"
    "emacs-org-present"
    "emacs-plantuml-mode"
    ;;"emacs-poetry"
    "emacs-typescript-mode"
    "emacs-org-superstar"
    "emacs-org-ref"
    "emacs-org-fancy-priorities"
    "emacs-org-noter"
    ;;"emacs-dash"
    "emacs-pdf-tools"
    "emacs-org-tree-slide"
    "emacs-org-download"
    ;;"emacs-emacsql"
    "emacs-ripgrep"
    "emacs-page-break-lines"
    "emacs-guix"
    ;;"emacs-zmq"
    "emacs-treemacs-extra"
    "emacs-treemacs"
    "emacs-tablist"
    "emacs-svg-lib"
    "emacs-svg-icon"
    ;;"emacs-prescient"
    "emacs-powershell"
    "emacs-project"
    "emacs-popper"
    "emacs-orderless"
    "emacs-cmake-mode"
    "emacs-magit"
    "emacs-lsp-mode"
    "emacs-jupyter"
    "emacs-f"
    "emacs-embark"
    ;;"emacs-emacsql-sqlite3"
    "emacs-dap-mode"
    "emacs-beacon"
    ;;"emacs-sqlite"
    "emacs-pretty-mode"
    "emacs-doom-themes"
    "emacs-yasnippet-snippets"
    "emacs-yasnippet"
    "emacs-xref"
    "emacs-which-key"
    ;;"emacs-vertico-posframe"
    "emacs-vertico"
    "emacs-use-package"
    ;;"emacs-transient"
    "emacs-so-long"
    "emacs-sml-mode"
    "emacs-smartparens"
    "emacs-org-roam-ui"
    "emacs-rainbow-mode"
    "emacs-rainbow-identifiers"
    "emacs-rainbow-delimiters"
    "emacs-pyvenv"
    "emacs-ox-reveal"
    "emacs-ox-pandoc"
    ;;"emacs-ox-hugo"
    "emacs-toc-org"
    "emacs-org-roam-bibtex"
    "emacs-org-reveal"
    "emacs-org-pomodoro"
    "emacs-org-drill"
    "emacs-ob-async"
    "emacs-nov-el"
    "emacs-modus-themes"
    "emacs-marginalia"
    "emacs-lua-mode"
    "emacs-lsp-ui"
    "emacs-lsp-treemacs"
    "emacs-keycast"
    "emacs-julia-repl"
    "emacs-julia-mode"
    "emacs-json-mode"
    "emacs-js2-mode"
    "emacs-hydra"
    "emacs-helpful"
    "emacs-graphviz-dot-mode"
    "emacs-graphql"
    "emacs-glsl-mode"
    "emacs-geiser-guile"
    ;;"emacs-geiser"
    "emacs-flycheck"
    "emacs-expand-region"
    "emacs-elfeed"
    "emacs-doom-modeline"
    "emacs-dashboard"
    "emacs-consult"
    "emacs-consult-lsp"
    "emacs-consult-org-roam"
    ;;"emacs-company-posframe"
    ;;"emacs-company-box"
    ;;"emacs-company"
    "emacs-bongo"
    "emacs-all-the-icons-dired"
    "emacs-all-the-icons-completion"
    "emacs-all-the-icons"
    "emacs-ace-window"
    ;;"emacs-websocket"
    ;;"emacs-simple-httpd"
    "emacs-visual-fill-column"
    "emacs-ef-themes"
    "emacs-saveplace-pdf-view"
    "emacs-citar"
    "emacs-citar-org-roam")))
 
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
