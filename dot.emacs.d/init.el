;;; -*- mode: emacs-lisp; coding: utf-8 -*-

(when (or (not (boundp 'server-process))
	  (not server-process))
  (server-start))

;;
;; elpa, melpa
;;

(require 'package)

; Add package-archives
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))

;;
;; Load all "*/subdirs.el" under this-dir.
;;
(let ((load-all-subdirs
       (lambda (this-dir)
         (let (fn err (default-directory this-dir))
           (dolist (file (cdr (cdr (directory-files this-dir))))
             (setq fn (concat (file-name-as-directory file) "subdirs.el"))
             (if (and (file-directory-p file)
                      (file-exists-p fn))
                 (condition-case err
                     (load fn)
                   (error
                    (message "Can't load %s: %s" fn err)))
               (message "load-all-subdirs: skipped %s" file)))))))
  (funcall load-all-subdirs
           (or (and load-file-name (file-name-directory load-file-name))
               default-directory)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(case-fold-search t)
 '(change-log-version-info-enabled t)
 '(cperl-close-paren-offset -2)
 '(cperl-continued-statement-offset 2)
 '(cperl-indent-parens-as-block nil)
 '(cperl-label-offset 0)
 '(global-font-lock-mode t nil (font-lock))
 '(line-spacing 1)
 '(make-backup-files nil)
 '(safe-local-variable-values (quote ((rpm-change-log-uses-utc . t) (c-indentation-style . bsd))))
 '(tool-bar-mode nil nil (tool-bar))
 '(version-control (quote never)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "さざなみゴシック" :foundry "unknown" :slant normal :weight normal :height 98 :width normal)))))
