;; ���Υե�����Τ���ǥ��쥯�ȥ�ʲ������٤ƤΥǥ��쥯�ȥ�� load-path ��
(let ((default-directory (file-name-directory load-file-name)))
  (normal-top-level-add-to-load-path (list default-directory))
  (normal-top-level-add-subdirs-to-load-path))
