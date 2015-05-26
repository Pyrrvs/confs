(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

(package-initialize) ;; You might already have this line

;;; Recursively Load Path
(let ((default-directory (expand-file-name (concat user-emacs-directory (convert-standard-filename "nonpackaged/")))))
  (setq load-path
	(append
	 (let ((load-path (copy-sequence load-path))) ;; Shadow
	   (append
	    (copy-sequence (normal-top-level-add-to-load-path '(".")))
	    (normal-top-level-add-subdirs-to-load-path)))
	 load-path)))
(setq load-path (cons (concat user-emacs-directory (convert-standard-filename "conf/")) load-path))

;;; configuration
(load "requires")
(load "c-lang")
(load "golang")
(load "tmux")
(load "ui")
(load "editor")

;;; MELPA
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(print "Configuration loaded")
