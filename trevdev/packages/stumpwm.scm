(define-module (trevdev packages stumpwm)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (trevdev packages lisp)
  #:export (sbcl-stumpwm-pamixer
            sbcl-stumpwm-contrib-notify))

(define sbcl-stumpwm-pamixer
  (let ((commit "aa820533c80ea1af5a0e107cea25eaf34e69dc24")
        (revision "3"))
    (package
      (name "sbcl-stumpwm-pamixer")
      (version (git-version "0.1.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/Junker/stumpwm-pamixer.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0djcrr16bx40l7b60d4j507vk5l42fdgmjpgrnk86z1ba8wlqim8"))))
      (inputs `(("stumpwm" ,stumpwm "lib")))
      (propagated-inputs (list pamixer))
      (build-system asdf-build-system/sbcl)
      (arguments '(#:asd-systems '(:pamixer)))
      (home-page "https://github.com/Junker/stumpwm-pamixer")
      (synopsis "StumpWM Pamixer Module")
      (description "Minimalistic Pulseaudio volume and microphone control
module for StumpWM.")
      (license license:gpl3))))

(define sbcl-stumpwm-contrib-notify
  (let ((commit "d0c05077eca5257d33083de949c10bca4aac4242")
        (revision "1"))
    (package
      (name "sbcl-stumpwm-contrib-notify")
      (version (git-version "0.0.1" revision commit)) ;no upstream release
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/stumpwm/stumpwm-contrib")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0zxhqh9wjfk7zas67kmwfx0a47y8rxmh8f1a5rcs300bv1083lkb"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       `(("stumpwm" ,stumpwm "lib")
         ("xml-emitter" ,sbcl-xml-emitter)
         ("dbus" ,sbcl-dbus)
         ("bordeaux-threads" ,sbcl-bordeaux-threads)))
      (arguments
       '(#:asd-systems '("notify")
         #:tests? #f
         #:phases
         (modify-phases %standard-phases
           (add-after 'unpack 'chdir
             (lambda _ (chdir "util/notify") #t)))))
      (home-page "https://github.com/stumpwm/stumpwm-contrib")
      (synopsis "Notifications server for StumpWM")
      (description "Implements org.freedesktop.Notifications
interface[fn:dbus-spec]. Shows notifications using stumpwm:message by default.")
      (license (list license:gpl2+ license:gpl3+ license:bsd-2)))))
