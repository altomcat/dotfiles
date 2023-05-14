(cons* (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
	(introduction
         (make-channel-introduction
          "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
          (openpgp-fingerprint
           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       (channel
	(name 'my-guix-packages)
	;; (url "git@github.com:altomcat/my-guix-packages.git")
        (url "https://github.com/altomcat/my-guix-packages.git")
	(commit "71d1ed6147dd9299de4a25eafde3057ec51d8e6c")
	(branch "master"))
       ;; Add pyros to Guix default channels.
       ;; (channel
       ;;  (name 'pyros)
       ;;  (url "https://github.com/pyros-dev/pyros-channel.git")
       ;;  (branch "master"))
       %default-channels)
