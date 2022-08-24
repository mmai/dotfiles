;; (add-to-load-path (dirname (current-filename)))
(include "./guix/guixconf/machines/asusZenbook.scm") ;; provides `swapdevice` & `filesystems`

(use-modules (gnu) (gnu packages shells))
(use-service-modules desktop networking ssh xorg)

;; Import nonfree linux module. ;; ajout nonguix
(use-modules (nongnu packages linux) ;; ajout nonguix
             (nongnu system linux-initrd)) ;; ajout nonguix

;; (use-modules (guix guixconf machines asusZenbook))

(operating-system
  (kernel linux) ;; ajout nonguix
  (initrd microcode-initrd) ;; ajout nonguix
  (firmware (list linux-firmware)) ;; ajout nonguix

  (locale "fr_FR.utf8")
  (timezone "Europe/Paris")
  (keyboard-layout (keyboard-layout "fr"))
  (host-name "henri-laptop")
  (users (cons* (user-account
                  (name "henri")
                  (comment "Henri")
                  (group "users")
                  (home-directory "/home/henri")
		  (shell (file-append zsh "/bin/zsh"))
                  (supplementary-groups
                    '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
  (packages
    (append
      (include "./guix/guixconf/base-desktop.scm")
      (list (specification->package "nss-certs"))
      %base-packages))
  (services

    (modify-services ;; ajout nonguix

    (append
      (list (service gnome-desktop-service-type)
            (service openssh-service-type)
            (set-xorg-configuration
              (xorg-configuration
                (keyboard-layout keyboard-layout))))
      %desktop-services)

	;; tout ce bloc : ajout nonguix
     (guix-service-type config => (guix-configuration
       (inherit config)
       (substitute-urls
	(append (list "https://substitutes.nonguix.org")
	  %default-substitute-urls))
       (authorized-keys
        (append (list (local-file "./nonguix-signing-key.pub"))
	  %default-authorized-guix-keys))))))

  (bootloader
    (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (target "/boot/efi")
      (keyboard-layout keyboard-layout)))

  (swap-devices swapdevice)
  (file-systems (append filesystems %base-file-systems)))
