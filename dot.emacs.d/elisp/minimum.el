(put 'narrow-to-region 'disabled nil)
(setq inhibit-default-init t);; ←大丈夫なのか？
(setq inhibit-startup-message t)
(put 'eval-expression 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(require 'cl)
;;
(if (< max-lisp-eval-depth 500)
    (setq max-lisp-eval-depth 500)
  )
;;
(defvar dot-emacs-log nil " .emacs をどこまで実行したか記録する log 変数")
(defmacro guarded-setting (comment &rest body)
  ".emacs を安全に処理できるようにする\(暫定版、無いよかマシ\)
\(guarded-setting \(COMMENT BODY\) \) として使う。
COMMENT には,BODY の大まかな意味を表現するような言葉を
 文字列として入れておく。
BODYが実際に評価され終ったら、大域変数 dot-emacs-log の先頭に
 COMMENT が付け足される。
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
 ;; ↑ mule2.0では、自分で書かなければならなくなった…
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
   "Fuction: 引数なし.
 カーソル位置から行端までコピー"
   (interactive) ;;これがないと、キーにバインドした時、動かない。
   (let ((tmp-pt (point)))
     (end-of-line)
     (copy-region-as-kill tmp-pt (point))
     (goto-char tmp-pt)))

 ;;; mview まわり
 (define-key ctl-x-map "\C-v" 'mview-mode)
 (autoload 'mview-file   "mview" nil t)
 (autoload 'mview-buffer "mview" nil t)
 (autoload 'mview-mode   "mview" nil t)
 (setq mview-mode-hook
       '(lambda ()
	  (local-set-key "o" 'other-window)
	  ;;;(local-set-key "\C-[." 'grep-id)
	  '(local-set-key "\C-[." 'my-tag-jump)))


;;; 最近付け加えたキーバインド
 (define-key ctl-x-map "\C-t" 'insert-timestamp)
 (define-key esc-map "\C-@" 'mark-word);;; ←使ってないね
 (define-key esc-map "\C-h" 'backward-kill-word)
 (define-key esc-map "\C-z" 'suspend-emacs)
 (define-key esc-map "\C-q" 'quoted-insert)

 (global-set-key "\C-t" 'forward-word)
 (global-set-key "\C-q" 'backward-word)

 ;;  (global-set-key "\C-u" 'universal-argument)
 (define-key esc-map "g" 'goto-line) ;;; 本当は'fill-region ←これも便利
 (define-key esc-map "m" 'my-mew) ;;; 時代はmew でしょう！
 ;; (define-key esc-map "m" 'mh)

 (define-key esc-map "\C-M" 'open-memo)

 (defun scroll-back-other-window ()
   "もう一つのウィンドウを逆スクロールさせる"
   (interactive)
   (scroll-other-window '-))
 (define-key esc-map "\C-r" 'scroll-back-other-window)
 
;;; C-z をプレフィックスにする！(vip モードとの兼ね合い)
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
   "だみ〜"
   (interactive "sパターン？: \nP")
   (occur regexp nlines)
   ;;; ↑ここを、call-interactively してると、
   ;;; my-occur が command-history に登録されない…
   (other-window 1)
   (mview-mode)
   (local-set-key "o" 'other-window)
   (local-set-key "." 'occur-mode-goto-occurrence))
 
 
;;; カーソルキーを使えるように…
; (define-prefix-command 'my-esc-brace-map)
; (setq my-esc-brace-map (make-keymap))
; (define-key esc-map "[" my-esc-brace-map)
; (define-key my-esc-brace-map "A" 'previous-line)
; (define-key my-esc-brace-map "B" 'next-line)
; (define-key my-esc-brace-map "C" 'forward-char)
; (define-key my-esc-brace-map "D" 'backward-char)
 
;;;  M-\[ を有効にするために…
 (global-set-key "\M-[" 'backward-paragraph)
;; (set-kanji-input-code "no conversion")

;;; バッファメニューで、 VI 風のカーソル移動
 (define-key Buffer-menu-mode-map "p" 'previous-line)
 (define-key Buffer-menu-mode-map "n" 'next-line)
 (define-key Buffer-menu-mode-map "k" 'previous-line)
 (define-key Buffer-menu-mode-map "j" 'next-line)
 (define-key Buffer-menu-mode-map "f" 'Buffer-menu-select)
 (define-key Buffer-menu-mode-map "v" 'Buffer-menu-select)
 (define-key Buffer-menu-mode-map "q" 'Buffer-menu-select)

;;; ディレクトリエディタで VI 風のカーソル移動
 (setq  dired-mode-hook
	'(lambda ()
	   (local-set-key "j" 'dired-next-line)
	   (local-set-key "k" 'dired-previous-line)
	   ;; もともとは、kill-lines
	   ;;(local-set-key "v" 'mview-file)
	   ))
 (define-key ctl-x-map "\C-d" 'dired)

;;;サーチ時のキーバインド！
 (cond ((boundp 'isearch-mode-map)
	;; emacs19, mule2.0 用では、keymap になる
	(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
	(define-key isearch-mode-map "\C-l" 'isearch-exit)
	;;
	(define-key isearch-mode-map "\C-q" 'isearch-other-control-char)
	;; ↓↑いや, やばいとは思うさ. でもねぇ.
	(define-key isearch-mode-map "\C-z" 'isearch-quote-char)
	)
       (t
	;; emacs 18 の頃のバインド.
	(setq search-delete-char ?\C-h)
	(setq search-exit-char   ?\C-l)
	)
       )


 ;; ============ その他の拡張ライブラリ =======================

;;prefix-region 複数の行頭に同じ文字列を一括して差し込む…
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

