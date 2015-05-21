;; Indent
(setq-default tab-width 4
              c-default-style "linux"
              c++-default-style "linux"
              c-basic-offset 4
              indent-tabs-mode nil)

;; Auto-completion
(add-hook 'c-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-c-headers)
            (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))
