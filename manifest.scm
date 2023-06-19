;; This "manifest" file can be passed to 'guix package -m' to reproduce
;; the content of your profile.  This is "symbolic": it only specifies
;; package names.  To reproduce the exact same profile, you also need to
;; capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.



(specifications->manifest
 (list
  ;; fonts
  ;;"font-mononoki"
  "font-iosevka-comfy"
  "font-openmoji"
  ;; useful tools
  "aspell"
  "aspell-dict-en"
  "aspell-dict-fr"
  "alacritty"
  ;;"gnome-terminal"
  "xrandr"
  "stow"
  "gnupg"
  "openssh"
  "git"
  "picom"
  "nitrogen"
  "volumeicon"
  "thunar"
  "ranger"
  ;;"unclutter"
  "slock"
  
  ;; webrowser 
  "qutebrowser"
  "xdg-utils" ;; for xdg-open

  ;; emacs stuff
  "emacs-next"
  "emacs-org-appear"
  "emacs-org-roam"
  "emacs-org-superstar"
  "emacs-org-ref"
  "emacs-org-fancy-priorities"
  "emacs-org-noter"
  "emacs-dash"
  "emacs-pdf-tools"
  "emacs-org-tree-slide"
  "emacs-org-download"
  "emacs-emacsql"
  "emacs-ripgrep"
  "emacs-page-break-lines"
  "emacs-guix"
  "emacs-zmq"
  "emacs-treemacs-extra"
  "emacs-treemacs"
  "emacs-tablist"
  "emacs-svg-lib"
  "emacs-svg-icon"
  "emacs-prescient"
  "emacs-powershell"
  "emacs-project"
  "emacs-popper"
  "emacs-pdf-tools"
  "emacs-orderless"
  "emacs-cmake-mode"
  ;; emacs-mastodon
  ;; emacs-markdown-mode
  "emacs-magit"
  "emacs-lsp-mode"
  "emacs-jupyter"
  ;; emacs-hlint-refactor-mode
  ;; emacs-hl-todo
  ;; emacs-google-translate
  "emacs-f"
  "emacs-embark"
  "emacs-emacsql-sqlite3"
  "emacs-emacsql"
  "emacs-dap-mode"
  ;; emacs-company-org-block
  ;; emacs-ccls
  "emacs-beacon"
  "emacs-sqlite"
  "emacs-pretty-mode"
  "emacs-org-roam"
  ;; emacs-lsp-java
  "emacs-doom-themes"
  "emacs-yasnippet-snippets"
  "emacs-yasnippet"
  "emacs-xref"
  "emacs-which-key"
  "emacs-vertico-posframe"
  "emacs-vertico"
  "emacs-use-package"
  "emacs-transient"
  ;; emacs-tramp-auto-auth
  ;; emacs-tramp
  "emacs-so-long"
  "emacs-sml-mode"
  "emacs-smartparens"
  "emacs-org-roam-ui"
  ;; emacs-selectrum
  ;; emacs-rustic
  ;; emacs-rust-mode
  ;; emacs-rjsx-mode
  "emacs-ripgrep"
  ;; emacs-rg
  "emacs-rainbow-mode"
  "emacs-rainbow-identifiers"
  "emacs-rainbow-delimiters"
  ;; emacs-rainbow-blocks
  ;;"emacs-racket-mode"
  "emacs-pyvenv"
  ;; emacs-python-environment
  ;; emacs-pulseaudio-control
  ;; emacs-prettier
  ;; emacs-pinentry
  "emacs-ox-reveal"
  "emacs-ox-pandoc"
  "emacs-ox-hugo"
  "emacs-toc-org"
  "emacs-org-roam-bibtex"
  "emacs-org-reveal"
  "emacs-org-pomodoro"
  ;;emacs-org-drill-table
  "emacs-org-drill"
  "emacs-ob-async"
  ;; emacs-oauth2
  "emacs-nov-el"
  ;; emacs-mpv
  "emacs-modus-themes"
  ;; emacs-marginalia-emprise
  "emacs-marginalia"
  "emacs-lua-mode"
  "emacs-lsp-ui"
  "emacs-lsp-treemacs"
  ;; emacs-lsp-metals
  ;; emacs-lsp-lua-emmy
  "emacs-keycast"
  ;; emacs-julia-snail
  "emacs-julia-repl"
  "emacs-julia-mode"
  "emacs-json-mode"
  ;; emacs-js2-refactor-el
  "emacs-js2-mode"
  "emacs-hydra"
  "emacs-helpful"
  "emacs-graphviz-dot-mode"
  "emacs-graphql"
  "emacs-glsl-mode"
  ;; emacs-gif-screencast
  ;;"emacs-geiser-racket"
  "emacs-geiser-guile"
  ;; emacs-geiser-gauche
  ;; emacs-geiser-chez
  "emacs-geiser"
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
  ;; emacs-corfu
  ;; emacs-consult-yasnippet
  ;; emacs-consult-org-roam
  ;; emacs-consult-notmuch
  ;; emacs-consult-lsp
  ;; emacs-consult-eglot
  ;; emacs-consult-dir
  ;; emacs-consult-bibtex
  "emacs-consult"
  ;; emacs-company-restclient
  ;; emacs-company-reftex
  ;; emacs-company-quickhelp
  "emacs-company-posframe"
  ;; emacs-company-math
  ;; emacs-company-lua
  ;; emacs-company-lsp
  ;; emacs-company-jedi
  ;; emacs-company-irony
  ;; emacs-company-flow
  ;; emacs-company-emoji
  ;; emacs-company-ebdb
  ;; emacs-company-cabal
  "emacs-company-box"
  ;; emacs-company-auctex
  "emacs-company"
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

  "emacs-ef-themes"
  "emacs-saveplace-pdf-view"
  "emacs-citar"
  "emacs-citar-org-roam"
  ))
