(define-module (trevdev packages ruby)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system ruby)
  #:use-module (gnu packages ruby)
  #:use-module ((guix licenses) #:prefix license:))

(define-public ruby-liquid-5.3
  (package
    (name "ruby-liquid")
    (version "5.3.0")
    (source (origin
              (method url-fetch)
              (uri (rubygems-uri "liquid" version))
              (sha256
               (base32
                "0b3nmab5vvn48mr0yrp5cryvdi1xw749jrkca0wwciv0wcb8y50v"))))
    (build-system ruby-build-system)
    (arguments `(#:tests? #f)); No rakefile
    (home-page "https://shopify.github.io/liquid/")
    (synopsis "Template language")
    (description "Liquid is a template language written in Ruby.  It is used
to load dynamic content on storefronts.")
    (license license:expat)))

(define-public ruby-listen-3.7
  (package
    (name "ruby-listen")
    (version "3.7.1")
    (source
     (origin
       ;; The gem does not include a Rakefile, so fetch from the Git
       ;; repository.
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/guard/listen")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "113ixsssv7y5j85766hvha5mw5bwwbck0plj8166rigbb05qwp9w"))))
    (build-system ruby-build-system)
    (arguments `(#:tests? #f)) ; https://github.com/guard/listen/issues/558
    (native-inputs
     (list bundler ruby-rspec))
    (inputs
     (list ;; ruby-thor is used for the command line interface, and is referenced
      ;; in the wrapper, and therefore just needs to be an input.
      ruby-thor))
    (propagated-inputs
     (list ruby-rb-fsevent ruby-rb-inotify ruby-dep))
    (synopsis "Listen to file modifications")
    (description "The Listen gem listens to file modifications and notifies
you about the changes.")
    (home-page "https://github.com/guard/listen")
    (license license:expat)))

(define-public ruby-bugsnag
  (package
    (name "ruby-bugsnag")
    (version "6.24.2")
    (source (origin
              (method url-fetch)
              (uri (rubygems-uri "bugsnag" version))
              (sha256
               (base32
                "0vlsqawqy8jn6cy03zcqw944p323zmr2lgadbw00m5r4lqc3bll4"))))
    (arguments '(#:tests? #f)) ; No rakefile
    (build-system ruby-build-system)
    (propagated-inputs (list ruby-concurrent))
    (synopsis "Ruby notifier for bugsnag.com")
    (description "The Bugsnag exception reporter for Ruby gives you instant
 notification of exceptions thrown from your Rails, Sinatra, Rack or plain
 Ruby app.")
    (home-page "https://github.com/bugsnag/bugsnag-ruby")
    (license license:expat)))

(define-public ruby-theme-check
  (package
    (name "ruby-theme-check")
    (version "1.10.3")
    (source (origin
              (method url-fetch)
              (uri (rubygems-uri "theme-check" version))
              (sha256
               (base32
                "00sqbnbz6bspdzgmcdiziql1lvf0gzxk74hlvwcqsdka78bg0nk0"))))
    (build-system ruby-build-system)
    (arguments '(#:tests? #f))
    (propagated-inputs `(("ruby-liquid" ,ruby-liquid-5.3)
                         ("ruby-nokogiri" ,ruby-nokogiri)
                         ("ruby-parser" ,ruby-parser)))
    (synopsis "A Shopify Theme Linter")
    (description "This package provides a Shopify Theme Linter")
    (home-page "https://github.com/Shopify/theme-check")
    (license license:expat)))

(define-public ruby-shopify-cli
  (package
    (name "ruby-shopify-cli")
    (version "2.24.0")
    (source (origin
              (method url-fetch)
              (uri (rubygems-uri "shopify-cli" version))
              (sha256
               (base32
                "13srr1f2jj0cc1plr2d34898w095g6ddj0a34rz60jsscfyjwz2i"))))
    (build-system ruby-build-system)
    (inputs `(("ruby-bugsnag" ,ruby-bugsnag)
              ("ruby-listen"  ,ruby-listen-3.7)))
    (propagated-inputs `(("ruby-theme-check" ,ruby-theme-check)))
    (arguments '(#:tests? #f))
    (synopsis "Shopify CLI helps you build Shopify themes and apps")
    (description "Use Shopify CLI to automate and enhance your local
 development workflow.")
    (home-page "https://github.com/Shopify/shopify-cli")
    (license license:expat)))
