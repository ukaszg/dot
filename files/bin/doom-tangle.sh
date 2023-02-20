#!/usr/bin/env sh
":"; exec emacs --quick --script "$0" -- "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-
 ;;; bin/doom-tangle.sh
;; Tangles source blocks from config.org file.

(require 'ox)
(require 'ob-tangle)
(unwind-protect
    (let (org-mode-hook
          org-confirm-babel-evaluate
          (config (file-truename "~/.doom.d/config.org"))
          (backup (make-temp-file "config" nil ".org")))
      (copy-file config backup t)
      (with-current-buffer (find-file-noselect backup)
        (org-export-expand-include-keyword)
        (org-babel-tangle)
        (set-buffer-modified-p nil)
        (kill-buffer))
      (ignore-errors (delete-file backup))))
(byte-recompile-directory (expand-file-name "~/.doom.d/") 0 t)
(kill-emacs 0)
