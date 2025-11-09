(cons* (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
	(introduction
         (make-channel-introduction
          "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
          (openpgp-fingerprint
           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       (channel
	(name 'bric-a-brac)
	(url "https://github.com/altomcat/bric-a-brac.git")
        (introduction
	 (make-channel-introduction
	  "9c87d2feb0c07dd6e62f13acfcbba53d8c1f5b3a"
	  (openpgp-fingerprint
	   "4FF9 5EA8 27FB 0BF7 C9CE 6F03 7284 5387 AAC2 2DE0"))))
       (channel
        (name 'guix-rust-past-crates)
        (url "https://codeberg.org/guix/guix-rust-past-crates.git")
        (branch "trunk")
        (introduction
         (make-channel-introduction
          "1db24ca92c28255b28076792b93d533eabb3dc6a"
          (openpgp-fingerprint
           "F4C2D1DF3FDEEA63D1D30776ACC66D09CA528292"))))
       ;; (channel
       ;; 	(name 'rde)
       ;; 	(url "https://git.sr.ht/~abcdw/rde")
       ;; 	(introduction
       ;; 	 (make-channel-introduction
       ;; 	  "257cebd587b66e4d865b3537a9a88cccd7107c95"
       ;; 	  (openpgp-fingerprint
       ;; 	   "2841 9AC6 5038 7440 C7E9  2FFA 2208 D209 58C1 DEB0"))))
       %default-channels)
