(define-module (trevdev packages gnome-xyz)
  #:use-module (gnu packages)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gettext)
  #:use-module (guix build utils)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (gnome-shell-extension-unite-shell))

(define gnome-shell-extension-unite-shell
  (package
    (name "gnome-shell-extension-unite-shell")
    (version "65")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/hardpixel/unite-shell")
             (commit "127edac6396b89cdedec003bdff38820e6a0f91f")))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1lzhf7hlvzg62nxjfpv265315qibcjz5dv08dzpfckf2dx68nab4"))))
    (build-system copy-build-system)
    (native-inputs (list `(,glib "bin") gettext-minimal))
    (arguments
     '(#:install-plan '(("./unite@hardpixel.eu"
                         "share/gnome-shell/extensions/unite@hardpixel.eu"))
      #:phases
      (modify-phases %standard-phases
        (add-before 'install 'compile-schemas
          (lambda _
            (with-directory-excursion "unite@hardpixel.eu/schemas"
              (invoke "glib-compile-schemas" ".")))))))
    (home-page "https://github.com/hardpixel/unite-shell")
    (synopsis "Top panel and window decoration extension for GNOME Shell")
    (description "Unite is a GNOME Shell extension which makes a few layout
tweaks to the top panel and removes window decorations to make it look like
Ubuntu Unity Shell.")
    (license license:gpl3)))
