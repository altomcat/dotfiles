(define-module (guix-config packages virtualization))

(define-public %my-virtualization-pkgs
  (list
   "virt-manager"
   "libvirt"
   "python-libvirt"
   "bridge-utils"
   "dconf" ;; store connections for virt-manager
   "qemu"
   ))
