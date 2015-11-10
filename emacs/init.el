(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

(require 'cask (concat (file-name-as-directory (getenv "CONF_HOME")) (concat (file-name-as-directory "cask") "cask.el")))
(cask-initialize)

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

(print "Configuration loaded")
