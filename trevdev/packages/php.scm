(define-module (trevdev packages php)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module (gnu packages php)
  #:export (php-composer))

(define php-composer
  (package
    (name "php-composer")
    (version "2.4.1")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://getcomposer.org/download/"
                                  version
                                  "/composer.phar"))
              (sha256
               (base32
                "19nwlvc2sjdxskxlawvnqafnn2c8fld8861qbijgjvy7iqqgd37a"))))
    (build-system copy-build-system)
    (inputs `(("php" ,php)))
    (arguments `(#:install-plan '(("composer.phar" "bin/composer"))))
    (home-page "https://getcomposer.org/")
    (synopsis "Manage dependencies for PHP projects")
    (description "Composer is a tool for dependency management in PHP. It allows
 you to declare the libraries your project depends on and it will manage
(install/update) them for you.")
    (license license:expat)))
