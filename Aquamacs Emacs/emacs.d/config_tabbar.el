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


;;------------------------------------------------------------------------------
;;tabbar美化，参考自：http://hi.baidu.com/fcl06/item/1043b9fefdbae65cc9f33782
;;------------------------------------------------------------------------------

;; Hooks based on yswzing's hooks, but modified for this function state.
;; called each time the modification state of the buffer changed
(defun ep-modification-state-change ()
  (tabbar-set-template tabbar-current-tabset nil)
  (tabbar-display-update))

;; first-change-hook is called BEFORE the change is made
(defun ep-on-buffer-modification ( a b c)
  ;;(set-buffer-modified-p t)
  (ep-modification-state-change))

(add-hook 'after-save-hook 'ep-modification-state-change)
;;(add-hook 'first-change-hook 'ep-on-buffer-modification)
(add-hook 'after-change-functions 'ep-on-buffer-modification)

(defvar tabbar-last-tab nil)

(defvar tabbar-close-tab-function nil
  "Function to call to close a tabbar tab.  Passed a single argument, the tab
construct to be closed.")

(defvar tabbar-new-tab-function nil
  "Function to call to create a new buffer in tabbar-mode.  Optional single
argument is the MODE for the new buffer.")

(defun tabbar-buffer-close-tab (tab)
  (let ((buffer (tabbar-tab-value tab)))
    (with-current-buffer buffer
      (kill-buffer buffer))))

(setq tabbar-close-tab-function 'tabbar-buffer-close-tab)

(defun tabbar-context-menu ()
  "Pop up a context menu."
  (interactive)
  (popup-menu (tabbar-popup-menu)))
(defun tabbar-popup-print ()
  "Print Buffer"
  (interactive))
(defun tabbar-popup-close ()
  "Tab-bar pop up close"
  (interactive)
  (funcall tabbar-close-tab-function tabbar-last-tab))
(defun tabbar-popup-close-but ()
  "Tab-bar close all BUT this buffer"
  (interactive)
  (let ((cur (symbol-value (funcall tabbar-current-tabset-function))))
    (mapc (lambda(tab)
            (unless (eq tab tabbar-last-tab)
              (funcall tabbar-close-tab-function tab)))
          cur)))
(defun tabbar-popup-save-as ()
  "Tab-bar save as"
  (interactive)
  (let* ((buf (tabbar-tab-value tabbar-last-tab)))
    (save-excursion
      (set-buffer buf)
      (call-interactively 'write-file))))
(defun tabbar-popup-save ()
  "Tab-bar save"
  (interactive)
  (let* ((buf (tabbar-tab-value tabbar-last-tab)))
    (save-excursion
      (set-buffer buf)
      (call-interactively 'save-buffer))))
(defun tabbar-popup-rename ()
  "Tab-bar rename"
  (interactive)
  (let* ((buf (tabbar-tab-value tabbar-last-tab))
         (fn (buffer-file-name buf)))
    (save-excursion
      (set-buffer buf)
      (when (call-interactively 'write-file)
        (if (string= fn (buffer-file-name (current-buffer)))
            (error "Buffer has same name.  Just saved instead.")
          (delete-file fn))))))
(defun tabbar-popup-delete ()
  "Tab-bar delete file"
  (interactive)
  (let* ((buf (tabbar-tab-value tabbar-last-tab))
                 (fn (buffer-file-name buf)))
    (when (yes-or-no-p (format "Are you sure you want to delete %s?" buf))
      (save-excursion
        (set-buffer buf)
        (set-buffer-modified-p nil)
        (kill-buffer (current-buffer))
        (delete-file fn)))))
(defun tabbar-popup-remove-compression-ext (file-name &optional new-compression)
  "Removes compression extension, and possibly adds a new extension"
  (let ((ret file-name))
    (when (string-match "\\(\\(?:\\.\\(?:Z\\|gz\\|bz2\\|tbz2?\\|tgz\\|svgz\\|sifz\\|xz\\|dz\\)\\)?\\)\\(\\(?:~\\|\\.~[0-9]+~\\)?\\)\\'" ret)
      (setq ret (replace-match (concat (or new-compression "") (match-string 2 ret)) t t ret)))
    (symbol-value 'ret)))
(defun tabbar-popup-gz (&optional ext err)
  "Gzips the file"
  (interactive)
  (let* ((buf (tabbar-tab-value tabbar-last-tab))
         (fn (buffer-file-name buf))
         (nfn (tabbar-popup-remove-compression-ext fn (or ext ".gz"))))
    (if (string= fn nfn)
        (error "Already has that compression!")
      (save-excursion
        (set-buffer buf)
        (write-file nfn)
        (if (not (file-exists-p nfn))
            (error "%s" (or err "Could not gzip file!"))
          (when (file-exists-p fn)
            (delete-file fn)))))))
(defun tabbar-popup-bz2 ()
  "Bzip file"
  (interactive)
  (tabbar-popup-gz ".bz2" "Could not bzip the file!"))
(defun tabbar-popup-decompress ()
  "Decompress file"
  (interactive)
  (tabbar-popup-gz "" "Could not decompress the file!"))
(defun tabbar-popup-menu ()
  "Keymap for pop-up menu.  Emacs only."
  `(,(format "%s" (nth 0 tabbar-last-tab))
    ["Close" tabbar-popup-close]
    ["Close all BUT this" tabbar-popup-close-but]
    "--"
    ["Save" tabbar-popup-save]
    ["Save As" tabbar-popup-save-as]
    "--"
    ["Rename File" tabbar-popup-rename
     :active (and (buffer-file-name (tabbar-tab-value tabbar-last-tab)) (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab))))]
    ["Delete File" tabbar-popup-delete
     :active (and (buffer-file-name (tabbar-tab-value tabbar-last-tab)) (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab))))]
    "--"
    ["Gzip File" tabbar-popup-gz
     :active (and (executable-find "gzip") (buffer-file-name (tabbar-tab-value tabbar-last-tab))
                  (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab)))
                  (not (string-match "\\.gz\\(?:~\\|\\.~[0-9]+~\\)?\\'" (buffer-file-name (tabbar-tab-value tabbar-last-tab)))))]
    ["Bzip File" tabbar-popup-bz2
     :active (and (executable-find "bzip2") (buffer-file-name (tabbar-tab-value tabbar-last-tab))
                  (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab)))
                  (not (string-match "\\.bz2\\(?:~\\|\\.~[0-9]+~\\)?\\'" (buffer-file-name (tabbar-tab-value tabbar-last-tab)))))]
    ["Decompress File" tabbar-popup-decompress
     :active (and
              (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab)))
              (string-match "\\(?:\\.\\(?:Z\\|gz\\|bz2\\|tbz2?\\|tgz\\|svgz\\|sifz\\|xz\\|dz\\)\\)\\(\\(?:~\\|\\.~[0-9]+~\\)?\\)\\'"
                            (buffer-file-name (tabbar-tab-value tabbar-last-tab))))
     ]
        ;;    "--"
    ;;    ["Print" tabbar-popup-print]
    )
  )


(defun tabbar-select-tab-callback (event)
  "Handle a mouse EVENT on a tab.
Pass mouse click events on a tab to `tabbar-click-on-tab'."
  (interactive "@e")
  (when (tabbar-click-p event)
    (let ((target (posn-string (event-start event))))
      (tabbar-click-on-tab
       (get-text-property (cdr target) 'tabbar-tab (car target))
       event
       (get-text-property (cdr target) 'tabbar-action (car target))))))

(defsubst tabbar-click-on-tab (tab &optional type action)
  "Handle a mouse click event on tab TAB.
Call `tabbar-select-tab-function' with the received, or simulated
mouse click event, and TAB.
Optional argument TYPE is a mouse click event type (see the function
`tabbar-make-mouse-event' for details)."
  (let* ((mouse-event (tabbar-make-mouse-event type))
         (mouse-button (event-basic-type mouse-event)))
    (if  (eq mouse-button 'mouse-3)
        (progn
          (setq tabbar-last-tab tab)
          (tabbar-context-menu))
          (if (eq action 'close-tab)
                  (when (and (eq mouse-button 'mouse-1) tabbar-close-tab-function)
                        (funcall tabbar-close-tab-function tab))
                (when tabbar-select-tab-function
                  (funcall tabbar-select-tab-function
                                   (tabbar-make-mouse-event type) tab)
                  (tabbar-display-update))))))


;; (defun tabbar-buffer-select-tab (event tab)
;;   "On mouse EVENT, select TAB."
;;   (let ((mouse-button (event-basic-type event))
;;         (buffer (tabbar-tab-value tab)))
;;     (cond
;;      ((eq mouse-button 'mouse-1)
;;       (switch-to-buffer buffer))
;;      ((eq mouse-button 'mouse-3)
;;       (pop-to-buffer buffer t))
;;      ((eq mouse-button 'mouse-2)
;;       (kill-buffer buffer)))
;;     ;; Disable group mode.
;;     (setq tabbar-buffer-group-mode nil)))
;; ;;-------------------------------------------
;; 
;;-------------------------------------------
;;(setq EmacsPortable-global-tabbar 't) ; If you want tabbar
;;(setq EmacsPortable-global-ruler 't) ; if you want a global ruler
;;(setq EmacsPortable-popup-menu 't) ; If you want a popup menu.
;;(setq EmacsPortable-popup-toolbar 't) ; If you want a popup toolbar
;;(require 'tabbar-ruler)
;;-------------------------------------------
;; 
;;-------------------------------------------
(defun tabbar-ruler-image (&key type disabled color)
  "Returns the scroll-images"
  (let ((clr (or color (if disabled "#0000FF" "#FF5500"))))
    (if (eq type 'close)
        (format "/* XPM */
        static char * close_tab_xpm[] = {
        \"14 11 3 1\",
        \"       c None\",
        \".      c %s\",
        \"+      c #D2D4D1\",
        \"     .....    \",
        \"    .......   \",
        \"   .........  \",
        \"  ... ... ... \",
        \"  .... . .... \",
        \"  ..... ..... \",
        \"  .... . .... \",
        \"  ... ... ... \",
        \"   .........  \",
        \"    .......   \",
        \"     .....    \"};" clr)
          (format
           "/* XPM */
static char * scroll_%s_%s_xpm[] = {
\"17 17 2 1\",
\"       c None\",
\".      c %s\",
\"                 \",
\"                 \",
\"                 \",
\"                 \",
\"                 \",
%s
\"                 \",
\"                 \",
\"                 \",
\"                 \",
\"                 \",
\"                 \"};
" (symbol-name type)
(if disabled "disabled" "enabled")
clr
(cond
 ((eq 'right type)
  "\"                 \",
\"     ..          \",
\"     ....        \",
\"     ......      \",
\"     .....       \",
\"     ...         \",
"
  )
 ((eq 'left type)
  "\"                 \",
\"          ..     \",
\"        ....     \",
\"      ......     \",
\"       .....     \",
\"         ...     \","
  )
 ((eq 'up type)
  "\"        .        \",
\"       ..        \",
\"       ...       \",
\"      ....       \",
\"      .....      \",
\"      .....      \",")
 ((eq 'down type)
  "\"      .....      \",
\"      .....      \",
\"      ....       \",
\"       ...       \",
\"       ..        \",
\"        .        \","))))))

(set-face-attribute 'tabbar-default nil
                    :inherit nil
		    :height 110
                    :weight 'normal
                    :width 'normal
                    :slant 'normal
                    :underline nil
                    :strike-through nil
                    ;; inherit from frame                   :inverse-video
                    :stipple nil
                    :background "#AAAAAA"
                    :foreground "black"
                    ;;             :box '(:line-width 2 :color "white" :style nil)
                    :box nil
                    :family "arial"
                    )
(set-face-attribute 'tabbar-selected nil
                    :background "#DDDDDD"
                    :foreground "black"
                    :inherit 'tabbar-default 
                    :box '(:line-width 3 :color "#DDDDDD" :style nil))
;;                  :box '(:line-width 2 :color "white" :style released-button))
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :background "#AAAAAA"
                    :box '(:line-width 3 :color "#AAAAAA" :style nil))
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
                    :box nil)
(set-face-attribute 'tabbar-separator nil
                    :background "grey50"
                    :foreground "grey50"
                    :height 1.0)
(defsubst tabbar-line-tab (tab)
  "Return the display representation of tab TAB.
That is, a propertized string used as an `header-line-format' template
element.
Call `tabbar-tab-label-function' to obtain a label for TAB."
  (let* ( (selected-p (tabbar-selected-p tab (tabbar-current-tabset)))
          (modified-p (buffer-modified-p (tabbar-tab-value tab)))
          (close-button-image (tabbar-find-image 
                                                           `((:type xpm :data ,(tabbar-ruler-image :type 'close :disabled (not modified-p))))))
          (face (if selected-p
                    (if modified-p
                        'tabbar-selected-modified
                      'tabbar-selected
                      )
                  (if modified-p
                      'tabbar-unselected-modified
                    'tabbar-unselected
                    ))))
    (concat
     (propertize "[x]"
                 'display (tabbar-normalize-image close-button-image 0)
                 'face face
                 'pointer 'hand
                 'tabbar-tab tab
                 'local-map (tabbar-make-tab-keymap tab)
                 'tabbar-action 'close-tab
                 )
     (propertize " " 'face face
                 'tabbar-tab tab
                 'local-map (tabbar-make-tab-keymap tab)
                 'help-echo 'tabbar-help-on-tab
                 'face face
                 'pointer 'hand
                 )
     (propertize 
      (if tabbar-tab-label-function
          (funcall tabbar-tab-label-function tab)
        tab)
      'tabbar-tab tab
      'local-map (tabbar-make-tab-keymap tab)
      'help-echo 'tabbar-help-on-tab
      'mouse-face 'tabbar-highlight
      'face face
      'pointer 'hand)
     (propertize (if modified-p
                                         ;;(with-temp-buffer (ucs-insert "207A") (insert " ") (buffer-substring (point-min) (point-max)))
                                         " " " ") 'face face
                                         'tabbar-tab tab
                                         'local-map (tabbar-make-tab-keymap tab)
                                         'help-echo 'tabbar-help-on-tab
                                         'face face
                                         'pointer 'hand)
     tabbar-separator-value)))
(defface tabbar-selected-modified
  '((t
     :inherit tabbar-selected
     :weight normal))
  "Face used for unselected tabs."
  :group 'tabbar)

(defface tabbar-unselected-modified
  '((t
     :inherit tabbar-unselected
     :weight normal))
  "Face used for unselected tabs."
  :group 'tabbar)
(defface tabbar-key-binding '((t
                               :foreground "white"))
  "Face for unselected, highlighted tabs."
  :group 'tabbar)
(setq tabbar-separator '(0.25))
(defface tabbar-selected-modified
  '((t
     :inherit tabbar-selected
     :weight normal))
  "Face used for unselected tabs."
  :group 'tabbar)
(defface tabbar-unselected-modified
  '((t
     :inherit tabbar-unselected
     :weight normal
     ))
  "Face used for unselected tabs."
  :group 'tabbar)
(defface tabbar-key-binding '((t
                               :foreground "white"))
  "Face for unselected, highlighted tabs."
  :group 'tabbar)
(provide 'tabbar-settings)
