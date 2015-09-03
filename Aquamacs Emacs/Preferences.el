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
;;                        UTILISATION DE TAB POUR L'INDENTATION UNIQUEMENT
;; conflits : yasnippet
;;################################################################################
(setq tab-always-indent t)

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
;; (setq initial-frame-alist '((top . 90)(left . 200)(width . 120)(height . 45)))
;; (add-to-list 'default-frame-alist '(width  . 120))
;; (add-to-list 'default-frame-alist '(height . 45))
;; (add-to-list 'default-frame-alist '(top . 100))
;; (add-to-list 'default-frame-alist '(left . 200))

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

;;################################################################################
;; Shell
;; 
;;################################################################################

;;; Fix junk characters in shell-mode
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;################################################################################
;; Org Mode
;; 
;;################################################################################
;; ORG mode
;(setq org-todo-keywords
					;     '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))

;;################################################################################
;; iBuffer
;; 
;;################################################################################
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
        (quote (("default"
                 ("Org" ;; all org-related buffers
                  (mode . org-mode))
                 ;; ("equfitter"
                 ;;  (filename . "equationfitter/"))
                 ("Programming C++" ;; prog stuff not already in MyProjectX
                  (or
                   (mode . c-mode)
                   (mode . c++-mode)
                   ))

                 ("Source Code" ;; non C++ related stuff.
                  (or
                   (mode . python-mode)
                   (mode . emacs-lisp-mode)
                   (mode . shell-script-mode)
                   (mode . f90-mode)
                   (mode . scheme-mode)
                   ;; etc
                   ))

                 ("LaTeX"
                  (or
                   (mode . tex-mode)
                   (mode . latex-mode)
                   (name . ".tex")
                   (name . ".bib")
                   ))

                 ("Text" (name . ".txt"))

                 ("Mail"
                  (or  ;; mail-related buffers
                   (mode . message-mode)
                   (mode . mail-mode)
                   (mode . mime-mode)
;;                   (mode . MIME-mode)

                   ;; etc.; all your mail related modes
                   ))

                 ("Web" (or (mode . html-mode)
                            (mode . css-mode)))

                 ("ERC"   (mode . erc-mode))

                 ;; ("Subversion" (name . "\*svn"))
                 ;; ("Magit" (name . "\*magit"))

                 ("Emacs-created"
                  (or
                   (name . "^\\*")))
                 ))))

  (add-hook 'ibuffer-mode-hook
            (lambda ()
              ;;(ibuffer-auto-mode 1)   ;auto update the buffer-list
              (ibuffer-switch-to-saved-filter-groups "default")))

  ;;Don't show (filter) groups that are empty.
  (setq ibuffer-show-empty-filter-groups nil)
  ;;(autoload 'ibuffer "ibuffer" "List buffers." t)

  ;; keep from warning, twice, about deleting buffers.
  ;; only warn about deleting modified buffers.
  (setq ibuffer-expert t)

(add-hook 'ibuffer-mode-hook (lambda () (ibuffer-auto-mode 1)))

(defun xah-ibuffer-keys ()
  "Modify keymaps used by `ibuffer'."
  (local-set-key (kbd "<down-mouse-1>") 'ibuffer-mouse-visit-buffer)
  )

(add-hook 'ibuffer-hook 'xah-ibuffer-keys)
;;; Make iBuffer go away when selecting a file
;;---------------------------------------------
(define-key ibuffer-mode-map [remap ibuffer-visit-buffer]
  '(lambda () (interactive)
     (ibuffer-visit-buffer t)))
;;---------------------------------------------

;; Use human readable Size column instead of original one

;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%7.3fM" (/ (buffer-size) 1000000.0)))
   ((> (buffer-size) 1000) (format "%7.3fk" (/ (buffer-size) 1000.0)))
   (t (format "%8d" (buffer-size)))))

;; (define-ibuffer-column size-h
;;   (:name "Size" :inline t)
;;   (cond
;;    ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
;;    ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
;;    ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
;;    (t (format "%8d" (buffer-size)))))

;; Modify the default ibuffer-formats
  (setq ibuffer-formats
	'((mark modified read-only " "
		(name 18 18 :left :elide)
		" "
		(size-h 9 -1 :right)
		" "
		(mode 16 16 :left :elide)
		" "
		filename-and-process)))
;;################################################################################
;; Yasnippet - Adding snippets (expanding pre defined text)
;; 
;;################################################################################
 (add-to-list 'load-path
               "~/Library/Preferences/Aquamacs Emacs/Packages/elpa/yasnippet-20150811.1222")
 (require 'yasnippet)
(yas-global-mode 1)

(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<M-S-tab> ") 'yas-expand)
;; (require 'yasnippet-bundle)
;; (require 'yasnippet)
;;(yas/initialize)

;;################################################################################
;; Use templates for files  - Adding templates to newly created files
;; Automatically done by default content
;; Or manually done in this file
;;################################################################################
(require 'defaultcontent)
; Note that you have to modify emacs.d/defaultcontent.el to add new file backbone

;;; Manually
;; (auto-insert-mode)  ; Enable the feature globally
;; ;;; Define what should get auto-inserted
;; (setq auto-insert-directory "~/Library/Preferences/Aquamacs Emacs/templates/")
;; (setq auto-insert-query nil)
;; (define-auto-insert "\.sh" "bash-template.sh")
;; (define-auto-insert "\.org" "org-template.org")
;; (define-auto-insert "\.tex" "tex-template.tex")
;; (define-auto-insert "\.c" "c-template.tex")
;;################################################################################
;; ORG mode
;; settings for the mobile org app
;;################################################################################

;; Set to the location of your Org files on your local system
(setq org-directory "~/Documents/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Documents/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Applications/MobileOrg")

