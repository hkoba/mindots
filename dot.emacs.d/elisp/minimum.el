(put 'narrow-to-region 'disabled nil)
(setq inhibit-default-init t);; ������פʤΤ���
(setq inhibit-startup-message t)
(put 'eval-expression 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(require 'cl)
;;
(if (< max-lisp-eval-depth 500)
    (setq max-lisp-eval-depth 500)
  )
;;
(defvar dot-emacs-log nil " .emacs ��ɤ��ޤǼ¹Ԥ�������Ͽ���� log �ѿ�")
(defmacro guarded-setting (comment &rest body)
  ".emacs ������˽����Ǥ���褦�ˤ���\(�����ǡ�̵���褫�ޥ�\)
\(guarded-setting \(COMMENT BODY\) \) �Ȥ��ƻȤ���
COMMENT �ˤ�,BODY ����ޤ��ʰ�̣��ɽ������褦�ʸ��դ�
 ʸ����Ȥ�������Ƥ�����
BODY���ºݤ�ɾ�����콪�ä��顢����ѿ� dot-emacs-log ����Ƭ��
 COMMENT ���դ�­����롣
"
  (setq uho (car body))
  (unwind-protect (while body (eval (car body)) (setq body (cdr body)))
    (setq dot-emacs-log (cons comment dot-emacs-log))))

(guarded-setting
 "key-bindings (global)"
 (global-set-key "\C-h" 'delete-backward-char)
 (global-set-key "\C-r" 'scroll-down)
 (global-set-key "\C-l" esc-map)
 (define-key esc-map "\C-i" 'lisp-complete-symbol)
 ;; �� mule2.0�Ǥϡ���ʬ�ǽ񤫤ʤ���Фʤ�ʤ��ʤä���
 (define-key esc-map "\C-x" 'eval-print-last-sexp)
 (define-key esc-map "\C-r" 'query-replace)

 (define-key esc-map "\C-l" 'recenter)
 (define-key esc-map "k" 'delete-window)
 (define-key esc-map "\C-s" 'set-mark-command)
 (define-key esc-map "\C-w" 'copy-region-as-kill)
 (define-key ctl-x-map "\C-c" 'save-buffers-kill-emacs)
 (define-key ctl-x-map "\C-b" 'buffer-menu)
 (define-key ctl-x-map "$" 'shell)

 ;;; 
 (define-key esc-map "\C-k" 'copy-to-end-of-line)
 (defun copy-to-end-of-line ()
   "Fuction: �����ʤ�.
 ����������֤����ü�ޤǥ��ԡ�"
   (interactive) ;;���줬�ʤ��ȡ������˥Х���ɤ�������ư���ʤ���
   (let ((tmp-pt (point)))
     (end-of-line)
     (copy-region-as-kill tmp-pt (point))
     (goto-char tmp-pt)))

 ;;; mview �ޤ��
 (define-key ctl-x-map "\C-v" 'mview-mode)
 (autoload 'mview-file   "mview" nil t)
 (autoload 'mview-buffer "mview" nil t)
 (autoload 'mview-mode   "mview" nil t)
 (setq mview-mode-hook
       '(lambda ()
	  (local-set-key "o" 'other-window)
	  ;;;(local-set-key "\C-[." 'grep-id)
	  '(local-set-key "\C-[." 'my-tag-jump)))


;;; �Ƕ��դ��ä��������Х����
 (define-key ctl-x-map "\C-t" 'insert-timestamp)
 (define-key esc-map "\C-@" 'mark-word);;; ���ȤäƤʤ���
 (define-key esc-map "\C-h" 'backward-kill-word)
 (define-key esc-map "\C-z" 'suspend-emacs)
 (define-key esc-map "\C-q" 'quoted-insert)

 (global-set-key "\C-t" 'forward-word)
 (global-set-key "\C-q" 'backward-word)

 ;;  (global-set-key "\C-u" 'universal-argument)
 (define-key esc-map "g" 'goto-line) ;;; ������'fill-region �����������
 (define-key esc-map "m" 'my-mew) ;;; �����mew �Ǥ��礦��
 ;; (define-key esc-map "m" 'mh)

 (define-key esc-map "\C-M" 'open-memo)

 (defun scroll-back-other-window ()
   "�⤦��ĤΥ�����ɥ���ե������뤵����"
   (interactive)
   (scroll-other-window '-))
 (define-key esc-map "\C-r" 'scroll-back-other-window)
 
;;; C-z ��ץ�ե��å����ˤ��롪(vip �⡼�ɤȤη�͹礤)
 (define-prefix-command 'my-epoch-map)
 (setq my-epoch-map (make-keymap))
 (global-set-key "\C-z" my-epoch-map)
 
 (define-key my-epoch-map "\C-e" 'vip-change-mode-to-emacs)
 (define-key my-epoch-map "\C-z" 'suspend-emacs)
 (define-key my-epoch-map "\C-s" 'rcs-update)
 (define-key my-epoch-map "\C-v" 'vip-change-mode-to-vi)
 (define-key my-epoch-map "\C-u" 'universal-argument)
 (define-key my-epoch-map "o" 'my-occur)
 (define-key my-epoch-map "e" 'eval-defun)
 (defun my-occur (regexp &optional nlines)
   "���ߡ�"
   (interactive "s�ѥ�����: \nP")
   (occur regexp nlines)
   ;;; ��������call-interactively ���Ƥ�ȡ�
   ;;; my-occur �� command-history ����Ͽ����ʤ���
   (other-window 1)
   (mview-mode)
   (local-set-key "o" 'other-window)
   (local-set-key "." 'occur-mode-goto-occurrence))
 
 
;;; �������륭����Ȥ���褦�ˡ�
; (define-prefix-command 'my-esc-brace-map)
; (setq my-esc-brace-map (make-keymap))
; (define-key esc-map "[" my-esc-brace-map)
; (define-key my-esc-brace-map "A" 'previous-line)
; (define-key my-esc-brace-map "B" 'next-line)
; (define-key my-esc-brace-map "C" 'forward-char)
; (define-key my-esc-brace-map "D" 'backward-char)
 
;;;  M-\[ ��ͭ���ˤ��뤿��ˡ�
 (global-set-key "\M-[" 'backward-paragraph)
;; (set-kanji-input-code "no conversion")

;;; �Хåե���˥塼�ǡ� VI ���Υ��������ư
 (define-key Buffer-menu-mode-map "p" 'previous-line)
 (define-key Buffer-menu-mode-map "n" 'next-line)
 (define-key Buffer-menu-mode-map "k" 'previous-line)
 (define-key Buffer-menu-mode-map "j" 'next-line)
 (define-key Buffer-menu-mode-map "f" 'Buffer-menu-select)
 (define-key Buffer-menu-mode-map "v" 'Buffer-menu-select)
 (define-key Buffer-menu-mode-map "q" 'Buffer-menu-select)

;;; �ǥ��쥯�ȥꥨ�ǥ����� VI ���Υ��������ư
 (setq  dired-mode-hook
	'(lambda ()
	   (local-set-key "j" 'dired-next-line)
	   (local-set-key "k" 'dired-previous-line)
	   ;; ��Ȥ�Ȥϡ�kill-lines
	   ;;(local-set-key "v" 'mview-file)
	   ))
 (define-key ctl-x-map "\C-d" 'dired)

;;;���������Υ����Х���ɡ�
 (cond ((boundp 'isearch-mode-map)
	;; emacs19, mule2.0 �ѤǤϡ�keymap �ˤʤ�
	(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
	(define-key isearch-mode-map "\C-l" 'isearch-exit)
	;;
	(define-key isearch-mode-map "\C-q" 'isearch-other-control-char)
	;; ��������, ��Ф��Ȥϻפ���. �Ǥ�ͤ�.
	(define-key isearch-mode-map "\C-z" 'isearch-quote-char)
	)
       (t
	;; emacs 18 �κ��ΥХ����.
	(setq search-delete-char ?\C-h)
	(setq search-exit-char   ?\C-l)
	)
       )


 ;; ============ ����¾�γ�ĥ�饤�֥�� =======================

;;prefix-region ʣ���ι�Ƭ��Ʊ��ʸ������礷�ƺ��������
;;
 (define-key ctl-x-map "\"" 'prefix-lines-region)
 (define-key esc-map "\"" 'remove-prefix-string-region)
 (autoload 'prefix-lines-region "prefix-region" "" t)
 (autoload 'remove-prefix-string-region "prefix-region" "" t)

;; 
;; browse-yank
 (autoload 'browse-yank "browse-yank.el" t t)
 (global-set-key "\C-x\C-y" 'browse-yank)

)

