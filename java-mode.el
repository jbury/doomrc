;;; +java-mode.el -*- lexical-binding: t; -*-


(add-hook 'java-mode-hook #'lsp!)

(setq! lsp-java-format-enabled t
       lsp-java-format-comments-enabled t
       lsp-java-format-settings-profile "GoogleStyle"
       lsp-java-format-settings-url "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"
       lsp-java-save-action-organize-imports t)

(setq! lsp-java-code-generation-use-blocks t
       lsp-java-code-generation-generate-comments t)

(setq! lsp-java-maven-download-sources t
       lsp-java-import-maven-enabled t)
