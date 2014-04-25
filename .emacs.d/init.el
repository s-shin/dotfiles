;;;
; init.el
; (C) 2012 Seki Shintaro <s2pch.luck at gmail.com>
; Created : 20120511
; Modified: 20120511
;;;

;;;
;;; Utility
;;;
;; OS detection
(defvar os-type nil)
(cond ((string-match "apple-darwin" system-configuration) ;; Mac
       (setq os-type 'mac))
      ((string-match "linux" system-configuration)        ;; Linux
       (setq os-type 'linux))
      ((string-match "freebsd" system-configuration)      ;; FreeBSD
       (setq os-type 'bsd))
      ((string-match "mingw" system-configuration)        ;; Windows
       (setq os-type 'win)))
(defun mac? ()
  (eq os-type 'mac))
(defun linux? ()
  (eq os-type 'linux))
(defun bsd? ()
  (eq os-type 'freebsd))
(defun win? ()
  (eq os-type 'win))

;;;
;;; UI
;;;
;; bars
(custom-set-variables
 '(tool-bar-mode nil nil (tool-bar))
 '(scroll-bar-mode nil)
 '(menu-bar-mode nil)
 )
;; window system
(setq initial-frame-alist
      (append (list
	       '(width . 80)
	       '(height . 40)
	       )))
;; mode row
(setq column-number-mode t)

;;;
;;; Key
;;;
;; Backspace -> Delete
(define-key global-map "\C-h" 'delete-backward-char)
;; Check emacs exactly quit.
(defun my-save-buffers-kill-emacs()
  (interactive)
  (if (y-or-n-p "quit emacs?")
      (save-buffers-kill-emacs)))
(global-set-key "\C-x\C-c" 'my-save-buffers-kill-emacs)
;; goto-line
(global-set-key "\M-g" 'goto-line)

;;;
;;; Misc
;;;
(when (mac?) 
  ;; open file in drag & drop
  (define-key global-map [ns-drag-file] 'ns-find-file)
  (setq ns-pop-up-frames nil)
  ;(setq ns-input-file (cdr ns-input-file))
  ;(define-key global-map [ns-drag-file] 'ns-input-file)
  )

;;;
;;; Editing
;;;
;; append line break in last line
(setq require-final-newline t)
;; delete auto save files after saving
(setq delete-auto-save-files t)
;; don't make backup file
(setq backup-inhibited t)
;; emphasize paren
(show-paren-mode t)
;; japanese language environment
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
;; font
; Mac OS X & Ricty
;; (when (mac?)
;;   (create-fontset-from-ascii-font "Ricty-15:weight=normal:slant=normal" nil "myricty")
;;   (set-fontset-font "fontset-myricty"
;; 		    'unicode
;; 		    (font-spec :family "Ricty" :size 15)
;; 		    nil
;; 		    'append)
;;   (add-to-list 'default-frame-alist '(font . "fontset-myrichty")))
;; (when (mac?)
;;   ; bug of window width in cocoa
;;   (create-fontset-from-ascii-font
;;    "-apple-Ricty-medium-normal-normal-15-*-*-*-*-m-0-iso10646-1" nil "myricty")
;;   (set-fontset-font "fontset-myricty"
;; 		    'japanese-jisx0208
;; 		    '("Ricty" . "jisx0208-sjis"))
;;   (set-fontset-font "fontset-myricty"
;; 		    'katakana-jisx0201
;; 		    '("Ricty" . "jisx0201-katakana"))
;;   (add-to-list 'default-frame-alist
;; 	       '(font . "fontset-myricty")))
(when (mac?)
  (set-face-attribute 'default nil :family "Ricty" :height 150)
  (set-fontset-font "fontset-default" 'japanese-jisx0208 '("Ricty" . "jisx0208-sjis"))
  (set-fontset-font "fontset-default" 'katakana-jisx0201 '("Ricty" . "jisx0201-katakana")))
;; Quartz 2D
(when (mac?)
  (setq mac-allow-anti-aliasing t))
;; emphasize current line
(global-hl-line-mode)
(set-face-background 'hl-line "#F0F0F0")


;;;
;;; External package
;;;
;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (end-of-buffer)
    (eval-print-last-sexp)))
(el-get 'sync)
;; redo
(global-undo-tree-mode t)
;; xcscope
; do nothing
;; haskell-mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)
;; nXML-mode
(add-to-list 'auto-mode-alist '("\\.html?$" . nxml-mode))
(add-hook 
 'nxml-mode-hook
 '(lambda ()
    (setq tab-width 2
	  indent-tabs-mode t
	  nxml-slash-auto-complete-flag t
	  nxml-child-indent 2
	  auto-fill-mode -1
	  )))
;; css-mode
(add-hook
 'css-mode-hook
 '(lambda ()
    (setq tab-width 4
	  indent-tabs-mode t
	  )))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
;; javascript-mode
(add-hook
 ;'javascript-mode-hook
 'js-mode-hook
 '(lambda ()
    (setq tab-width 4
	  indent-tabs-mode t
	  )))
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
;; php-mode
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
;(setq php-mode-force-pear t)
(add-hook 'php-mode-hook
          (lambda ()
            (c-set-offset 'case-label' 4)
            (c-set-offset 'arglist-intro' 4)
            (c-set-offset 'arglist-cont-nonempty' 4)
            (c-set-offset 'arglist-close' 0)))



