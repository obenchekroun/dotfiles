(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 307 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(custom-enabled-themes (quote (subatomic)))
 '(custom-safe-themes
   (quote
    ("0d8921c6408a88108c03352fe5a905518a38ee3ab05613c164c141b4b6fb2a76" "b6f42c69cf96795c75b1e79e5cd8ca62f9f9a0cb07bf11d1e0b49f97785358f1" default)))
 '(default-frame-alist
    (quote
     ((left . 200)
      (top . 100)
      (height . 45)
      (width . 120)
      (cursor-type . box)
      (vertical-scroll-bars . right)
      (internal-border-width . 0)
      (modeline . t)
      (fringe)
      (mouse-color . "black")
      (cursor-color . "orange")
      (background-mode . dark)
      (tool-bar-lines . 1)
      (menu-bar-lines . 1)
      (right-fringe . 0)
      (left-fringe . 6)
      (background-color . "#303347")
      (foreground-color . "#e5e5e5")
      (font . "-*-DejaVu Sans Mono-normal-normal-normal-*-10-*-*-*-m-0-iso10646-1")
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
 '(org-agenda-files (quote ("~/Documents/org/Courses HEC.org")))
 '(tabbar-mode 1 nil (tabbar))
 '(text-mode-hook nil)
 '(visual-line-mode nil t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Buffer-menu-mode-default ((t (:inherit tabulated-list-mode-default :height 100 :family "DejaVu Sans Mono"))) t)
 '(calendar-mode-default ((t (:inherit autoface-default :height 100 :family "DejaVu Sans Mono"))) t)
 '(ibuffer-mode-default ((t (:inherit special-mode-default :height 100 :family "DejaVu Sans Mono"))) t)
 '(latex-mode-default ((t (:inherit tex-mode-default :stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 100 :width normal :family "DejaVu Sans Mono"))))
 '(linum ((t (:foreground "#696e92" :background "##484866" :box nil))))
 '(org-agenda-mode-default ((t (:inherit autoface-default :height 100 :family "DejaVu Sans Mono"))) t)
 '(org-mode-default ((t (:inherit outline-mode-default :stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 100 :width normal :family "DejaVu Sans Mono"))))
 '(text-mode-default ((t (:inherit autoface-default :stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 100 :width normal :family "DejaVu Sans Mono")))))


;; Linum customization
(setq linum-format " %d ")
(set-face-foreground 'font-lock-comment-delimiter-face  "#696e92")
(set-face-attribute 'fringe nil :background "#303347" :foreground "#303347")
;;    (setq linum-format "%d") ;; alternative solution to intermittent line numbers
 
(eval-after-load 'linum
  '(progn
     (defface linum-leading-zero
       `((t :inherit 'linum
            :foreground ,(face-attribute 'linum :background nil t)))
       "Face for displaying leading zeroes for line numbers in display margin."
       :group 'linum)
     (defun linum-format-func (line)
       (let ((w (length
                 (number-to-string (count-lines (point-min) (point-max))))))
         (concat
;;        (propertize (make-string (- w (length (number-to-string line))) ?0)
          (propertize (make-string (- w (length (number-to-string line))) ? ) ;; change leading zero to a soft space
                      'face 'linum-leading-zero)
          (propertize (number-to-string line) 'face 'linum))))
     (setq linum-format 'linum-format-func)))

;;; Filling gaps in linum bar
(defvar endless/margin-display
  `((margin left-margin) ,(propertize "     " 'face 'linum))
  "String used on the margin.")
(defvar-local endless/margin-overlays nil
  "List of overlays in current buffer.")

(defun endless/setup-margin-overlays ()
  "Put overlays on each line which is visually wrapped."
  (interactive)
  (let ((ww (- (window-width)
               (if (= 0 (or (cdr fringe-mode) 1)) 1 0)))
        ov)
    (mapc #'delete-overlay endless/margin-overlays)
    (save-excursion
      (goto-char (point-min))
      (while (null (eobp))
        ;; On each logical line
        (forward-line 1)
        (save-excursion
          (forward-char -1)
          ;; Check if it has multiple visual lines.
          (while (>= (current-column) ww)
            (endles/make-overlay-at (point))
            (forward-char (- ww))))))))

(defun endles/make-overlay-at (p)
  "Create a margin overlay at position P."
  (push (make-overlay p (1+ p)) endless/margin-overlays)
  (overlay-put
   (car endless/margin-overlays) 'before-string
   (propertize " "  'display endless/margin-display)))
(add-hook 'linum-before-numbering-hook #'endless/setup-margin-overlays)

