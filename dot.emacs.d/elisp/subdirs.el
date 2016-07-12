;; -*- coding: utf-8 -*-
;; このファイルのあるディレクトリ以下、すべてのディレクトリを load-path へ
(let ((default-directory (file-name-directory load-file-name)))
  (normal-top-level-add-to-load-path (list default-directory))
  (normal-top-level-add-subdirs-to-load-path)
  (load "minimum.el"))
