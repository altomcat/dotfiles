(define-module (guix-config services podman)
  #:use-module  (gnu services)
  #:use-module  (guix gexp))

(define-public (my-podman-home-service user)
  (simple-service 'subuid-subgid etc-service-type
		  (list `("subuid"
			  ,(plain-file "subuid"
				       (string-append user ":100000:65536" "\n")))
			`("subgid"
			  ,(plain-file "subgid"
				       (string-append user ":100000:65536" "\n")))))
  (simple-service 'podman-containers-conf etc-service-type
		  (list `("containers/policy.json"
			  ,(plain-file "policy.json"
				       "{\"default\": [{\"type\": \"insecureAcceptAnything\"}]}" )))))
