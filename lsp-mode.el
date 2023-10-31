;;; +lsp-mode.el -*- lexical-binding: t; -*-

(after! yaml-ts-mode
  (add-hook 'yaml-ts-mode-hook #'lsp!))

(after! lsp-mode
  (setq! read-process-output-max (* 1024 1024)
         company-idle-delay 1
         company-minimum-prefix-length 3)

  (setq! +lsp-company-backends 'company-capf)

  (setq! lsp-log-io nil
         lsp-enable-suggest-server-download nil
         lsp-enable-symbol-highlighting nil
         lsp-response-timeout 120
         lsp-modeline-diagnostics-scope :workspace
         lsp-terraform-ls-enable-show-reference t
         lsp-terraform-ls-prefill-required-fields t
         lsp-terraform-ls-validate-on-save t)

  (setq! lsp-go-goimports-local "gitlab.com/flexe"
         lsp-go-use-gofumpt t
         lsp-go-use-placeholders nil
         lsp-diagnostics-provider :auto)

  ;; :json-false
  (setq! lsp-go-codelenses '((gc_details . t) (generate . t) (regenerate_cgo . t) (run_govulncheck . t)
                             (test . t) (tidy . t) (upgrade_dependency . t) (vendor . t))

         lsp-go-analyses '((appends . t) (asmdecl . t) (assign . t) (atomic . t) (atomicalign . t) (bools . t)
                           (buildtag . t) (cgocall . t) (composites . t) (copylocks . t) (deepequalerrors . t) (defers . t)
                           (deprecated . t) (embed . t) (fieldalignment . t) (httpresponse . t) (ifaceassert . t)
                           (loopclosure . t) (lostcancel . t) (nilness . t) (printf . t) (shadow . t) (shift . t)
                           (simplifycompositelit . t) (simplifyrange . t) (simplifyslice . t) (slog . t) (sortslice . t)
                           (stdmethods . t) (stringintconv . t) (structtag . t) (testinggoroutine . t) (tests . t) (timeformat . t)
                           (unmarshal . t) (unreachable . t) (unsafeptr . t) (unusedparams . t) (unusedresult . t) (unusedwrite . t)
                           (useany . t) (fillreturns . t) (nonewvars . t) (undeclaredname . t) (unusedvariable . t) (fillstruct . t)
                           (infertypeargs . t) (stubmethods . t)))

  (setq! lsp-go-directory-filters ["-**/node_modules" "-**/.direnv" "-**/.devenv"])

  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t)))

  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.devenv\\'"))


(after! (:and lsp-mode treemacs-mode lsp-treemacs)
  (lsp-treemacs-sync-mode 1))
