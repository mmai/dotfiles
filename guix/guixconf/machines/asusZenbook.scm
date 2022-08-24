;; (define-module (guix guixconf machines asusZenbook)
;;   #:export (swapdevice filesystems))

(use-modules (gnu))

(define swapdevice 
  (list (uuid "8cd9db7a-125e-4aca-be35-36fc9af38be1")))

(define filesystems 
  (list (file-system
           (mount-point "/boot/efi")
           (device (uuid "232C-B4D6" 'fat32))
           (type "vfat"))
         (file-system
           (mount-point "/")
           (device
             (uuid "ed1d31c7-266b-46af-ac76-92b986058bec"
                   'ext4))
           (type "ext4"))))
