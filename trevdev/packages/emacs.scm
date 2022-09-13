(define-module (trevdev packages emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix build-system emacs)
  #:use-module (guix git-download)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages mail)
  #:export (emacs-ol-notmuch
            emacs-lsp-mode-with-plists))

(define emacs-ol-notmuch
  (let ((commit "1a53d6c707514784cabf33d865b577bf77f45913")
        (revision "0"))
    (package
      (name "emacs-ol-notmuch")
      (version (git-version "2.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://git.sr.ht/~tarsius/ol-notmuch")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "16p7j51z8r047alwn2hkb6944f7ds29ckb97b4k8ia00vwch0d67"))))
      (build-system emacs-build-system)
      (propagated-inputs (list emacs-notmuch
                               emacs-compat
                               emacs-org))
      (home-page "https://git.sr.ht/~tarsius/ol-notmuch")
      (synopsis "Store notmuch messages as org-mode links.")
      (description "This package implements links to notmuch messages and
 \"searches\". A search is a query to be performed by notmuch; it is the
equivalent to folders in other mail clients. Similarly, mails are referred to
by a query, so both a link can prefer to several mails.")
      (license license:gpl3))))

(define emacs-lsp-mode-with-plists
  (package
    (inherit emacs-lsp-mode)
    (name "emacs-lsp-mode-with-plists")
    (arguments
     `(#:emacs ,emacs                 ;need libxml support
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'move-clients-libraries
           ;; Move all clients libraries at top-level, as is done, e.g., in
           ;; MELPA.
           (lambda _
             (for-each (lambda (f)
                         (install-file f "."))
                       (find-files "clients/" "\\.el$"))))
         (add-before 'move-clients-libraries 'fix-patch-el-files
           ;; /bin/ksh is only used on macOS, which we don't support, so we
           ;; don't want to add it as input.
           (lambda _
             (substitute* '("clients/lsp-csharp.el" "clients/lsp-fsharp.el")
               (("/bin/ksh") "ksh"))))
         (add-before 'fix-patch-el-files 'env-plists-true
           (lambda _
             (setenv "LSP_USE_PLISTS" "true"))))))))
