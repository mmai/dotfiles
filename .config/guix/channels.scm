(cons* 
  (channel
    (name 'channel-rhumbs)
    (url "file:///home/henri/dotfiles/")) ;; a channel directory must be a git repo, it contains a .guix-channel file which indicates the subdirectory where actual modules are stored
  (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        ;; Enable signature verification:
        (introduction
         (make-channel-introduction
          "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
          (openpgp-fingerprint
           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       %default-channels)
