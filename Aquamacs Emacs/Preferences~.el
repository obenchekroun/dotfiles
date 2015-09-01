;; This is the Aquamacs Preferences file.
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messags* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;;(setq-default ispell-program-name "/usr/local/bin/aspell")

;(add-to-list 'load-path "~/Library/Preferences/Aquamacs Emacs/emacs.d/")
;;; Charge any additional tool

;;(require 'sr-speedbar)


;;Comportement clavier
;Function = meta
;Option = comportement normal
;(setq mac-function-modifier 'meta)
;(setq mac-option-modifier 'none)

;;################################################################################
;;                                  UTF-8 for all
;;################################################################################

(set-terminal-coding-system 'utf-8)
    (set-keyboard-coding-system 'utf-8)
    (prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(setq-default cursor-type 'bar) 

;;################################################################################
;;                                  Correction orthographique
;;################################################################################
;;; Not needed in Aquamacs

;;(setq ispell-program-name "/usr/local/Cellar/ispell/3.3.02/bin/ispell")
;; flyspell
;;(setq-default ispell-program-name "/usr/local/bin/aspell")


;;################################################################################
;;                                            THUMBS-MODE
;;################################################################################
 (autoload 'thumbs "thumbs" "Preview images in a directory." t)

;;################################################################################
;;                                  ACTIVER LA COLORATION SYNTAXIQUE
;;################################################################################
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(setq font-lock-maximum-size nil)

;;################################################################################
;;                  NUMÉROTATION DES LIGNES EST DES COLONNES
;;################################################################################
;; Show line-number in the mode line
(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)

;;################################################################################
;;                        POUR AVOIR L'HEURE DANS LA BARRE D'ETAT
;;################################################################################
(display-time-mode 1)
(setq display-time-24hr-format t)

;;################################################################################
;; FERME AUTOMATIQUEMENT PARENTHÈSES, CROCHETS, GUILLEMETS
;; AU COURS DE LA FRAPPE
;;################################################################################

(defun insert-parentheses () "insert parentheses and go between them"
  (interactive)
(insert "()")
(backward-char 1))
(defun insert-brackets () "insert brackets and go between them" (interactive)
(insert "[]")
(backward-char 1))
(defun insert-braces () "insert curly braces and go between them" (interactive)
(insert "{}")
(backward-char 1))
(defun insert-quotes () "insert quotes and go between them" (interactive)
(insert "\"\"")
(backward-char 1))
(defun insert-french () "insert brackets and go between them" (interactive)
(insert "\\og  \\fg")
(backward-char 4))
(global-set-key "(" 'insert-parentheses) ;;inserts "()"
(global-set-key "[" 'insert-brackets)
(global-set-key "{" 'insert-braces)
(global-set-key "\"" 'insert-quotes)
(global-set-key "|" 'insert-french)

;;################################################################################
;; TEX mode
;;################################################################################
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)

(add-hook 'LaTeX-mode-hook (lambda () (linum-mode 1)))

;;################################################################################
;; Complétion automatique
;;################################################################################

(abbrev-mode t) ; completion automatique
(global-set-key (quote [S-tab]) (quote dabbrev-expand))

;;################################################################################
;; ESS
;;################################################################################
;; ;ess-mode configuration
 (setq ess-ask-for-ess-directory nil) 
 (setq inferior-R-program-name "/usr/bin/R") 
 (setq ess-local-process-name "R") 
 (setq ansi-color-for-comint-mode 'filter) 
 (setq comint-scroll-to-bottom-on-input t) 
 (setq comint-scroll-to-bottom-on-output t) 
 (setq comint-move-point-for-output t)
(setq ess-eval-visibly-p nil)

;;################################################################################
;; Fenêtre
;;################################################################################
;; Taille et position par defaut de la fenetre
(setq initial-frame-alist '((top . 90)(left . 200)(width . 120)(height . 45)))
(add-to-list 'default-frame-alist '(width  . 120))
(add-to-list 'default-frame-alist '(height . 45))
(add-to-list 'default-frame-alist '(top . 100))
(add-to-list 'default-frame-alist '(left . 200))

;; Application d'un thème color-theme
;(add-to-list 'custom-theme-load-path "~/Library/Preferences/Aquamacs Emacs/")
;(load-theme 'subatomic t)
;(color-theme-initialize)
;(color-theme-subatomic)
;(load-theme 'spacegray t)

;; Syntaxe highlighting pour tout
(require 'font-lock)
(setq initial-major-mode
      (lambda ()
    (text-mode)
    (font-lock-mode)))
(setq font-lock-mode-maximum-decoration t
      font-lock-use-default-fonts t
      font-lock-use-default-colors t)

;; on change le nom de la fenetre par le nom du fichier edité 
 (setq frame-title-format '(buffer-file-name "Emacs: %b (%f)" "Emacs: %b"))

(setq linum-format "%4d")
(global-linum-mode 1)

(global-visual-line-mode 1) ;;                        POUR LA TRONCATURE EN FIN DE LIGNE PAR MOT
;;################################################################################
;; TABBAR
;; 
;;################################################################################

;;(load "tabbar")
(load "config_tabbar_aquamacs")
;(eval-after-load "tabbar"
 ;     (tabbar-mode))

(tabbar-mode 1)


;; ####################################Comportement à la UI classique############


 (dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
      (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation"))
    (defmacro defun-prefix-alt (name on-no-prefix on-prefix &optional do-always)
      `(defun ,name (arg)
         (interactive "P")
         ,do-always
         (if (equal nil arg)
             ,on-no-prefix
           ,on-prefix)))
    (defun-prefix-alt shk-tabbar-next (tabbar-forward-tab) (tabbar-forward-group) (tabbar-mode 1))
    (defun-prefix-alt shk-tabbar-prev (tabbar-backward-tab) (tabbar-backward-group) (tabbar-mode 1))
    (global-set-key [(control tab)] 'shk-tabbar-next)
    (global-set-key [(control shift tab)] 'shk-tabbar-prev)(global-set-key [alt-left] 'tabbar-backward-tab)
 
;;################################################################################
;; Dired
;; 
;;################################################################################
(add-hook 'dired-mode-hook 'my-dired-mode-hook)
(defun my-dired-mode-hook ()
  (local-set-key (kbd "<mouse-2>") 'dired-mouse-find-file))

(defun dired-mouse-find-file (event)
  "In Dired, visit the file or directory name you click on."
  (interactive "e")
  (require 'cl)
  (flet ((find-file-other-window
          (filename &optional wildcards)
          (find-file filename wildcards)))
    (dired-mouse-find-file-other-window event)))

;;; Fix junk characters in shell-mode
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
