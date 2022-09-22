(define-module (trevdev packages stumpwm)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix build utils)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module ((gnu packages wm) #:prefix wm-upstream:)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (trevdev packages lisp)
  #:export (sbcl-stumpwm-contrib-notify))

(define sbcl-stumpwm-pamixer ; Now available via Guix upstream
  (let ((commit "aa820533c80ea1af5a0e107cea25eaf34e69dc24")
        (revision "5"))
    (package
      (name "sbcl-stumpwm-pamixer")
      (version (git-version "0.1.1" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/Junker/stumpwm-pamixer")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "0djcrr16bx40l7b60d4j507vk5l42fdgmjpgrnk86z1ba8wlqim8"))))
      (inputs (list `(,stumpwm "lib") pamixer))
      (build-system asdf-build-system/sbcl)
      (arguments
       (list #:asd-systems ''(:pamixer)
             #:phases #~(modify-phases %standard-phases
                          (add-after 'unpack 'patch-pamixer
                            (lambda _
                              (substitute* "pamixer.lisp"
                                (("\"pamixer \"")
                                 (string-append "\""
                                                #$(this-package-input
                                                   "pamixer")
                                                "/bin/pamixer \""))))))))
      (home-page "https://github.com/Junker/stumpwm-pamixer")
      (synopsis "StumpWM Pamixer Module")
      (description "Minimalistic Pulseaudio volume and microphone control
module for StumpWM.")
      (license license:gpl3))))

(define sbcl-stumpwm-contrib-notify ; Now available via Guix upstream
  (package (inherit wm-upstream:sbcl-stumpwm-notify)))
