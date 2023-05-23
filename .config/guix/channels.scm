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
	(url "https://github.com/altomcat/my-guix-pkgs.git")
        (introduction
	 (make-channel-introduction
	  "cb7dbb3911da911e06146d4a7bde372c4b5a4783"
	  (openpgp-fingerprint
	   "AA52 B3F3 E764 5F95 6BA1 23E2 43D7 A3F7 7931 A85D")))
	)
       %default-channels)
