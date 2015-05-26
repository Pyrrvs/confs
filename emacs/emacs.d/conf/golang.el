(setq goroot (getenv "GOROOT"))
(setq gopath (getenv "GOPATH"))
(setq exec-path (cons (concat goroot (convert-standard-filename "bin")) exec-path))
(add-to-list 'exec-path (concat gopath (convert-standard-filename "bin")))
(load-file (concat gopath (convert-standard-filename "src/golang.org/x/tools/cmd/oracle/oracle.el")))
(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "\C-x4 M-.") 'godef-jump-other-window)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go generate && go build -v && go test -v && go vet"))
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)
