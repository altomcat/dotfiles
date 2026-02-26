(define-module (guix-config tools helper)
  #:use-module (gnu)
  #:use-module (guix)
  ;;  #:export (defined-user-name)
  ;;  #:export (defined-system-name)
  ;; #:export (defined-user-auto-login)
  #:export (auto-login-to-tty))

(define defined-user-name
  `(get-user this-operating-system))

(define defined-system-name
  `(get-system-name system-name))

(define (defined-user-auto-login config tty)
  (auto-login-to-tty config tty defined-user-name))

(define (get-user-name system-config)
  (user-account-name (car (operating-system-users system-config))))

(define (get-system-name system-config)
  (operating-system-label systm-config))

(define (auto-login-to-tty config tty user)
  (if (string=? tty (mingetty-configuration-tty config))
      (mingetty-configuration
       (inherit config)
       (auto-login user))
      config))
