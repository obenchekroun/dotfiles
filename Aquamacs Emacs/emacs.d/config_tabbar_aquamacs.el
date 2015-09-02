;;;;; Pour la config de tabbar


;;#################################### Tests sur l'aspect de tabbar

 ;;;;;;#############################Aspect tabbar#######################################

;;;; Aspect couleurs

;; ;; change faces for better-looking tabs (and more obvious selected tab!)
;; ;; full face specification to avoid inheriting from the frame font
;; ;; or from mode-line
;; (set-face-attribute 'tabbar-default nil
;; 		    :inherit nil
;; 		    :height 110
;; 		    :weight 'normal
;; 		    :width 'normal
;; 		    :slant 'normal
;; 		    :underline nil
;; 		    :strike-through nil
;; inherit from frame		    :inverse-video
;; 		    :stipple nil
;; 		    :background "gray80"
;; 		    :foreground "black"
;; ;		    :box '(:line-width 2 :color "white" :style nil)
;; 		    :box nil
;; 		    :family "Lucida Grande")

;; (set-face-attribute 'tabbar-selected nil
;; 		    :background "gray95"
;; 		    :foreground "gray20"
;; 		    :inherit 'tabbar-default
;; 		    :box '(:line-width 3 :color "grey95" :style nil))
;; ; 		    :box '(:line-width 2 :color "white" :style released-button))

;; (set-face-attribute 'tabbar-unselected nil
;; 		    :inherit 'tabbar-default
;; 		    :background "gray80"
;; 		    :box '(:line-width 3 :color "grey80" :style nil))

;; (defface tabbar-selected-highlight '((t
;; 		    :foreground "black"
;; 		    :background "gray95"))
;;   "Face for selected, highlighted tabs."
;;   :group 'tabbar)

;; (defface tabbar-unselected-highlight '((t
;;                     :foreground "black"
;; 		    :background "grey75"
;; 		    :box (:line-width 3 :color "grey75" :style nil)))
;;   "Face for unselected, highlighted tabs."
;;   :group 'tabbar)

;; (set-face-attribute 'tabbar-button nil
;; 		    :inherit 'tabbar-default
;; 		    :box nil)

;; (set-face-attribute 'tabbar-separator nil
;; 		    :background "grey50"
;;  		    :foreground "grey50"
;; 		    :height 1.0)

;;(setq tabbar-separator '(1)) ;; set tabbar-separator size to 1 pixel

;; (defface tabbar-selected-modified
;;   '((t
;;      :inherit tabbar-selected
;;      :weight bold
;;      :height 110
;;      ))
;;   "Face used for unselected tabs."
;;   :group 'tabbar)

;; (defface tabbar-unselected-modified
;;   '((t
;;      :inherit tabbar-unselected
;;      :weight bold
;;      :height 110
;;      ))
;;   "Face used for unselected tabs."
;;   :group 'tabbar)

;; (defface tabbar-key-binding '((t
;; 				 :foreground "white"))
;;     "Face for unselected, highlighted tabs."
;;     :group 'tabbar)



;;######################################################################




;;; ####################################Comportement à la UI classique
;;######################################################################
;;######################################################################
;;######################################################################


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
 

;; ;;(defun tabbar-buffer-tab-label (tab)
;; ;;   "Return a label for TAB.
;; ;; That is, a string used to represent it on the tab bar."
;;   (let ((label  (if tabbar--buffer-show-groups
;;                     (format "[%s]  " (tabbar-tab-tabset tab))
;;                   (format "%s  " (tabbar-tab-value tab)))))

;; ;;     ;; Unless the tab bar auto scrolls to keep the selected tab
;; ;;     ;; visible, shorten the tab label to keep as many tabs as possible
;; ;;     ;; in the visible area of the tab bar.
;;     (if tabbar-auto-scroll-flag
;;         label
;;       (tabbar-shorten
;;        label (max 1 (/ (window-width)
;;                        (length (tabbar-view
;;                                 (tabbar-current-tabset)))))))))


;;;;;; rangement par projet (= dossier quand possible)

(require 'tabbar)
   (tabbar-mode t)
    (setq tabbar-cycle-scope 'tabs)
    (setq tabbar-buffer-groups-function
          (lambda ()
              (let ((dir (expand-file-name default-directory)))
            (cond ((member (buffer-name) '("*Completions*"
                           "*scratch*"
                           "*Messages*"
                           "*Ediff Registry*"))
             (list "#misc"))
              ((string-match-p "/.emacs.d/" dir)
             (list ".emacs.d"))
              (t (list dir))))))
;#######################################################################################
;;#######################################################################################
;;####################################

;;------------------------------------------------------------------------------
;;tabbar
;;------------------------------------------------------------------------------
(require 'tabbar)
(tabbar-mode t)
(message "* MESSAGE * Je charge bien config-tabbar-aquamacs")
