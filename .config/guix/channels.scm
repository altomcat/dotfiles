(cons* (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
	;;(commit "637e728111993c06d5f0acd47156a653251994cd")
	)
       (channel
        (name 'guix)
        (url "https://git.savannah.gnu.org/git/guix.git")
	;;(commit "9cb35c02164d929fcb8929e7f454df215df8cf25")
	)
       ;; Add pyros to Guix default channels.
       ;; (channel
       ;;  (name 'pyros)
       ;;  (url "https://github.com/pyros-dev/pyros-channel.git")
       ;;  (branch "master"))
       %default-channels)
