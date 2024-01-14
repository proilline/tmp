(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   '("p" . "C-x p") ;; for project.el
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("v" . meow-right-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("/" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '(":" . meow-goto-line)
   '("y" . meow-save)
   '("?" . vundo)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))

(require 'meow)
(meow-setup)
(meow-global-mode 1)


(setq prefer-coding-system 'utf-8
      pgtk-use-im-context nil
      pgtk-use-im-context-on-new-connection nil
      make-backup-files nil
      inhibit-compacting-font-caches t
      read-process-output-max (* 1024 1024))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(add-hook 'prog-mode-hook
	  'display-line-numbers-mode)

(electric-pair-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
(savehist-mode)
(global-auto-revert-mode)

(add-to-list 'default-frame-alist '(font . "monospace-13"))
(set-face-attribute 'default nil
		    :family "monospace-13")


(set-frame-font "monospace-13" nil t)
(global-set-key "\C-x\C-b" 'switch-to-buffer)
(global-set-key "\C-xb" 'ibuffer)

(require 'corfu)
(global-corfu-mode)
(setq completion-cycle-threshold 3
      tab-always-indent 'complete
      corfu-cycle t
      corfu-auto t
      corfu-auto-prefix 8
      corfu-auto-delay 2)

(define-key corfu-map "TAB" 'corfu-next)
(define-key corfu-map "[tab]" 'corfu-next)
(define-key corfu-map "\M-j" 'corfu-next)
(define-key corfu-map "\M-k" 'corfu-previous)
(define-key corfu-map "\M-SPC" 'corfu-insert-separator)

(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides
      '((file (styles basic partial-completion))))

;; use fido caz fido uses emacs's internal icomplete api
(fido-mode t)

;; use orderless style completion with fido
(add-hook 'icomplete-minibuffer-setup-hook
	  '(lambda () (setq-local completion-styles
				  '(orderless basic))))
;; todo : fix some visual clutters

(define-key icomplete-fido-mode-map
	    "\M-l" 'icomplete-forward-completions)
(define-key icomplete-fido-mode-map
	    "\M-h" 'icomplete-backward-completions)

(define-key icomplete-fido-mode-map
	    "TAB" 'icomplete-force-complete)

(define-key icomplete-fido-mode-map
	    "[tab]" 'icomplete-force-complete)

(require 'popper)
(require 'popper-echo)
(require 'project)

(setq popper-display-control 't
      popper-group-function #'popper-group-by-project
      popper-reference-buffers '("^\\*eshell.*\\*$" eshell-mode
				 "^\\*shell.*\\*$" shell-mode
				 "^\\*vterm.*\\*$" vterm-mode
				 compilation-mode
				 comint-mode
				 "Output\\*$"
				 "\\*Messages\\*"
				 help-mode
				 "\\*Async Shell Command\\*"))

(popper-mode +1)
(popper-echo-mode +1)

(global-set-key "\M-`" 'popper-toggle)
(global-set-key "\M-c" 'popper-cycle)
(global-set-key "\M-t" 'popper-toggle-type)

(require 'imenu-list)
(global-set-key "\M-m" 'imenu-list)


(require 'eglot)
(setq eglot-extend-to-xref 't
      eglot-events-buffer-size '0 ;; disable logging for speedup
      eglot-autoshutdown 't)

(define-key eglot-mode-map "\C-c C-r" 'eglot-rename)
(define-key eglot-mode-map "\C-c C-o"
	    'eglot-code-action-organize-imports)

(define-key eglot-mode-map "\C-c C-h" 'eldoc)

(require 'vundo)
(define-key vundo-mode-map "h" 'vundo-backward)
(define-key vundo-mode-map "j" 'vundo-next)
(define-key vundo-mode-map "k" 'vundo-previous)
(define-key vundo-mode-map "l" 'vundo-forward)
(load-theme 'solarized-light t)

(require 'mood-line)
(mood-line-mode)

;; show column indicator
(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)


(setq tramp-default-method "ssh")

(require 'embark)
(global-set-key (kbd "M-SPC") 'embark-act)

(setq enable-recursive-minibuffers t
      embark-indicators '(embark-mixed-indicator))

(add-to-list 'display-buffer-alist
             '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
               nil
               (window-parameters (mode-line-format . none))))

(defun with-doas-prefix (filename) (concat "/doas::" filename))

(defun doas-find-file (filename &optional wildcards) ;; FIXME
  "Calls find-file with filename with doas-tramp-prefix prepended"
  (interactive "fFind file with doas ")      
  (let ((doas-name (with-doas-prefix filename)))
    (apply 'find-file 
           (cons doas-name (if (boundp 'wildcards) '(wildcards))))))

(defun doas-reopen-file ()
  "Reopen file as root by prefixing its name with doas-tramp-prefix and by clearing buffer-read-only"
  (interactive)
  (let* 
      ((file-name (expand-file-name buffer-file-name))
       (doas-name (with-doas-prefix file-name)))
    (progn           
      (setq buffer-file-name doas-name)
      (rename-buffer doas-name)
      (setq buffer-read-only nil)
      (message (concat "Set file name to " doas-name)))))

(require 'super-save)
(super-save-mode +1)

(require 'markdown-mode) ;; for eglot

(defun activate-input-method-wrapper ()
  (let ((prev-input-method current-input-method))
    (setq-local current-input-method nil)
    (activate-input-method prev-input-method)))

(defun deactivate-input-method-wrapper ()
  (let ((prev-input-method current-input-method)
	(prev-input-method-title current-input-method-title))

    (deactivate-input-method)
    (setq-local current-input-method prev-input-method
		current-input-method-title prev-input-method-title)))

(defun input-method-activate-guard ()
  (when (not (or (meow-insert-mode-p)
		 (meow-motion-mode-p)
		 (minibufferp)))
    (deactivate-input-method-wrapper)))

(add-hook 'meow-insert-exit-hook 'deactivate-input-method-wrapper)
(add-hook 'meow-insert-enter-hook 'activate-input-method-wrapper)
(add-hook 'input-method-activate-hook 'input-method-activate-guard)

(setq default-input-method "korean-hangul")
(global-set-key (kbd "<Hangul>") 'toggle-input-method)

;; TODO : modeline에 한글/영어 indicator 추가
;; TODO : 한글 fallback font 잘 설정하기. pretendard나 써볼까.


(require 'espotify)
(setq espotify-client-id "6764c053ddf64fefb1d4398434da0bc0"
      espotify-client-secret "3a4ac8f2182b465880483ca12fe627ad")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "4c7228157ba3a48c288ad8ef83c490b94cb29ef01236205e360c2c4db200bb18" default))
 '(package-selected-packages
   '(consult-spotify espotify simple-modeline markdown-mode super-save embark mood-line vundo solarized-theme nord-theme popper orderless imenu-list vertico meow corfu)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
