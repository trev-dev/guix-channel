(define-module (trevdev packages gnome)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages pulseaudio)
  #:use-module (guix packages)
  #:export (gnome-minimal))

(define gnome-minimal
  (package
    (inherit gnome)
    (name "gnome-minimal")
    (propagated-inputs
     (list
      ;; GNOME-Core-OS-Services
      accountsservice
      network-manager
      packagekit
      upower
      ;; GNOME-Core-Shell
      adwaita-icon-theme
      gdm
      glib-networking
      gnome-backgrounds
      gnome-bluetooth
      gnome-color-manager
      gnome-control-center
      gnome-desktop
      gnome-initial-setup
      gnome-keyring
      gnome-menus
      gnome-session
      gnome-settings-daemon
      gnome-shell-extensions
      gnome-shell
      gnome-themes-extra
      gnome-user-docs
      gnome-user-share
      gsettings-desktop-schemas
      gvfs
      mutter
      ;; orca
      ;; rygel
      sushi
      ;; GNOME-Core-Utilities
      baobab
      cheese
      ;; epiphany
      evince
      ;; file-roller
      ;; gedit
      gnome-boxes
      ;; gnome-calculator
      gnome-calendar
      ;; gnome-characters
      ;; gnome-clocks
      ;; gnome-contacts
      gnome-disk-utility
      gnome-font-viewer
      ;; gnome-maps
      ;; gnome-music
      ;; gnome-photos
      gnome-screenshot
      gnome-system-monitor
      ;; gnome-terminal
      ;; gnome-weather
      ;; nautilus
      simple-scan
      ;; totem
      ;; tracker-miners
      ;; Others
      hicolor-icon-theme
      gnome-online-accounts

      ;; Packages not part of GNOME proper but that are needed for a good
      ;; experience.  See <https://bugs.gnu.org/39646>.
      ;; XXX: Find out exactly which ones are needed and why.
      font-abattis-cantarell
      font-dejavu
      at-spi2-core-minimal
      dbus
      dconf
      desktop-file-utils
      gnome-default-applications
      gst-plugins-base
      gst-plugins-good
      gucharmap
      pinentry-gnome3
      pulseaudio
      shared-mime-info
      system-config-printer
      xdg-user-dirs
      yelp
      zenity))))
