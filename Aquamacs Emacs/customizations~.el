(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 307 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(custom-enabled-themes (quote (spacegray)))
 '(custom-safe-themes
   (quote
    ("b6f42c69cf96795c75b1e79e5cd8ca62f9f9a0cb07bf11d1e0b49f97785358f1" "ac2b1fed9c0f0190045359327e963ddad250e131fbf332e80d371b2e1dbc1dc4" "3ed645b3c08080a43a2a15e5768b893c27f6a02ca3282576e3bc09f3d9fa3aaa" "d8f76414f8f2dcb045a37eb155bfaa2e1d17b6573ed43fb1d18b936febc7bbc2" "6f3060ac8300275c990116794e1ba897b6a8af97c51a0cb226a98759752cddcf" "dc46381844ec8fcf9607a319aa6b442244d8c7a734a2625dac6a1f63e34bc4a6" "86e74c4c42677b593d1fab0a548606e7ef740433529b40232774fbb6bc22c048" "8d3fd54c8ccc81768ade3897e06646225d4ff7fe2c7ef1c8ee669ff85a3285b1" default)))
 '(default-frame-alist
    (quote
     ((width . 120)
      (left . 200)
      (top . 100)
      (height . 45)
      (width . 110)
      (cursor-type . box)
      (vertical-scroll-bars . right)
      (internal-border-width . 0)
      (modeline . t)
      (fringe)
      (mouse-color . "black")
      (cursor-color . "black")
      (background-mode . light)
      (tool-bar-lines . 1)
      (menu-bar-lines . 1)
      (right-fringe . 9)
      (left-fringe . 1)
      (background-color . "White")
      (foreground-color . "Black")
      (font . "-*-Helvetica-normal-normal-normal-*-11-*-*-*-p-0-iso10646-1")
      (fontsize . 0)
      (font-backend mac-ct ns))))
 '(display-time-mode t)
 '(global-flyspell-mode t)
 '(global-linum-mode t)
 '(global-visual-line-mode 1)
 '(ns-alternate-modifier (quote none))
 '(ns-function-modifier (quote meta))
 '(ns-tool-bar-display-mode (quote both) t)
 '(ns-tool-bar-size-mode (quote regular) t)
 '(tabbar-mode 1 nil (tabbar))
 '(text-mode-hook nil)
 '(visual-line-mode nil t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "nil" :family "Helvetica"))))
 '(latex-mode-default ((t (:inherit text-mode-default :stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 110 :width normal :family "Helvetica"))))
 '(text-mode-default ((t (:inherit autoface-default :stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 110 :width normal :family "Helvetica")))))

(setq linum-format "%4d")
(global-linum-mode 1)
(global-visual-line-mode 1)
