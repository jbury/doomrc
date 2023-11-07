;;; +defaults.el -*- lexical-binding: t; -*-

;; lsp ephemera
(setq max-lisp-eval-depth 10000)

(setq! frame-inhibit-implied-resize t                  ; I use a tiling window manager, don't try and force a size
       undo-limit 80000000                             ; undo-limit of 80Mb
       auto-save-default t                             ; auto-save by default so I don't lose stuff
       scroll-margin 2                                 ; little bit of scroll margin
       ediff-diff-options "-w -d"                      ; ignore whitespace and try harder to find a minimal set of changes
       browse-url-firefox-new-window-is-tab t          ; tabs plz
       browse-url-browser-function 'browse-url-firefox ; in firefox
       window-combination-resize t                     ; take new window space from err'body
       x-stretch-cursor nil                            ; DO NOT make the cursor match the size of the glyph
       backup-by-copying t                             ; copy backup files don't copy the original
       display-line-numbers-type t                     ; line numbers GOOD actually?!?
       confirm-kill-emacs nil                          ; Did I stutter?
       show-trailing-whitespace t)                     ; I don't like trailing whitespace

;; make sure I can move through words
(global-subword-mode 1)

;; fonts
(setq doom-font "Iosevka Fixed:style=Light:size=20"
      ;; doom-symbol-font (font-spec :family "Noto Sans")
      doom-big-font-increment 4)

(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)

(setq catppuccin-flavor 'mocha)
(setq doom-theme 'catppuccin)

;; clean up the which key menus a bit since there is so much evil-* spam
(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))))

;; https://github.com/emacs-lsp/lsp-mode/issues/2255
(defface lsp-flycheck-info-unnecessary
  '((t))
  "Face which apply to side line for symbols not used.
Possibly erroneously redundant of lsp-flycheck-info-unnecessary-face."
  :group 'lsp-ui-sideline)
