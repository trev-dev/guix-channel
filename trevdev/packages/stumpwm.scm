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
  (let ((commit "c5b2ff652f789a393cee5cb126c2625fe08d2c44")
        (revision "1"))
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
          (base32 "019cxcyjlp588sgdpp4j2k330x4w1j0crq15vp3hhmzhxkgdfnna"))))
      (inputs `(("stumpwm:lib" ,stumpwm "lib")))
      (build-system asdf-build-system/source)
      (home-page "https://github.com/Junker/stumpwm-pamixer")
      (synopsis "StumpWM Pamixer Module")
      (description "Minimalistic Pulseaudio volume and microphone control
module for StumpWM.")
      (license license:gpl3))))
