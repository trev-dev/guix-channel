(define-module (trevdev packages lisp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages lisp-check)
  #:export (sbcl-xml-emitter))

(define sbcl-xml-emitter
  (package
    (name "sbcl-xml-emitter")
    (version "1.1.0")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/VitoVan/xml-emitter.git")
                    (commit "1a93a5ab084a10f3b527db3043bd0ba5868404bf")))
              (sha256
               (base32
                "1w9yx8gc4imimvjqkhq8yzpg3kjrp2y37rjix5c1lnz4s7bxvhk9"))))
    (build-system asdf-build-system/sbcl)
    (inputs `(("cl-utilities" ,sbcl-cl-utilities)
              ("1am" ,sbcl-1am)))
    (synopsis "A common lisp library for emitting XML output")
    (description "Simply emit XML, with some complexity for handling indentation.
It can be used to produce all sorts of useful XML output; it has an RSS 2.0
 emitter built in, so you can make RSS feeds trivially.")
    (home-page "https://www.cliki.net/xml-emitter")
    (license license:expat)))
