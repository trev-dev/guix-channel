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
  #:export (sbcl-stumpwm-pamixer))

(define-public sbcl-stumpwm-pamixer
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
