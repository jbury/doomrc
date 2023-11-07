;;;###autoload
(defun +ginkgo--+go--run-tests (args)
  "Run tests with the defined command"
  (let ((cmd (concat "ginkgo run --succinct " args)))
    (setq +go-test-last (concat "cd " default-directory ";" cmd))
    (+go--spawn cmd)))

;;;###autoload
(defun +ginkgo--+go/test-all ()
  "Run all tests recursively"
  (interactive)
  (let ((cmd (concat "cd " (projectile-project-root) ";ginkgo run --succinct -r")))
    (setq +go-test-last cmd)
    (+go--spawn cmd)))

;;;###autoload
(defun +ginkgo--+go/test-package ()
  (interactive)
  (+go--run-tests "-r ."))

;;;###autoload
(defun +ginkgo--+go/test-file ()
  "Run all tests in current file"
  (interactive)
  (if (string-match "_test\\.go" buffer-file-name)
      (+go--run-tests (concat "--focus-file " buffer-file-name))
    (error "Must be in a _test.go file")))

;;;###autoload
(defun +ginkgo--+go/test-single ()
  "Run single test at point"
  (interactive)
  (if (string-match "_test\\.go" buffer-file-name)
      (save-excursion
        (re-search-backward "^[[:space:]]*\\(It\\|Specify\\)\(\"\\([^\"]+\\)\".*$")
        (+go--run-tests (concat "-r --focus-file " buffer-file-name " --focus " "'\\Q" (match-string-no-properties 2) "\\E'")))
    (error "Must be in a _test.go file")))
