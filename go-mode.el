;;; +go-mode.el -*- lexical-binding: t; -*-

(map! :after go-ts-mode
      :map go-ts-mode-map
      :localleader
      "a" #'go-tag-add
      "d" #'go-tag-remove
      "e" #'+go/play-buffer-or-region
      "i" #'go-goto-imports      ; Go to imports
      (:prefix ("h" . "help")
               "." #'godoc-at-point     ; Lookup in godoc
               "d" #'go-guru-describe   ; Describe this
               "v" #'go-guru-freevars   ; List free variables
               "i" #'go-guru-implements ; Implements relations for package types
               "p" #'go-guru-peers      ; List peers for channel
               "P" #'go-guru-pointsto   ; What does this point to
               "r" #'go-guru-referrers  ; List references to object
               "e" #'go-guru-whicherrs  ; Which errors
               "w" #'go-guru-what       ; What query
               "c" #'go-guru-callers    ; Show callers of this function
               "C" #'go-guru-callees)   ; Show callees of this function
      (:prefix ("ri" . "imports")
               "a" #'go-import-add)
      (:prefix ("b" . "build")
       :desc "go run ." "r" (cmd! (compile "go run ."))
       :desc "go build" "b" (cmd! (compile "go build"))
       :desc "go clean" "c" (cmd! (compile "go clean")))
      (:prefix ("t" . "test")
               "t" #'+go/test-rerun
               "a" #'+go/test-all
               "s" #'+go/test-single
               "n" #'+go/test-nested
               "f" #'+go/test-file
               "g" #'go-gen-test-dwim
               "G" #'go-gen-test-all
               "e" #'go-gen-test-exported
               (:prefix ("b" . "bench")
                        "s" #'+go/bench-single
                        "a" #'+go/bench-all)))

(after! go-mod-ts-mode
  (add-hook 'go-mod-ts-mode-hook #'lsp!))

(after! go-ts-mode
  (add-hook 'go-ts-mode-hook #'lsp!)
  (setq! treesit-font-lock-level 4
         go-ts-mode-indent-offset 4) ;; angry fruit salad
  (set-docsets! 'go-ts-mode "Go")
  (set-repl-handler! 'go-ts-mode #'gorepl-run)
  (set-lookup-handlers! 'go-ts-mode
    :definition #'go-guru-definition
    :references #'go-guru-referrers
    :documentation #'godoc-at-point))

(after! (:or go-mode go-ts-mode)
  (setq gofmt-command 'goimports)

  ;; I use advice for the below because there are a couple of other commands
  ;; that utilize the advised commands and they work just fine
  ;; This is a little dumb
  (defadvice! +ginkgo--+go--run-tests-a (args)
    :override #'+go--run-tests
    (+ginkgo--+go--run-tests args))

  (defadvice! +ginkgo--+go/test-all-a ()
    :override #'+go/test-all
    (+ginkgo--+go/test-all))

  (defadvice! +ginkgo--+go/test-file-a ()
    :override #'+go/test-file
    (+ginkgo--+go/test-file))

  (defadvice! +ginkgo--+go/test-single-a ()
    :override #'+go/test-single
    (+ginkgo--+go/test-single)))
