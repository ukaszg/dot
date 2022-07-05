;;; publish.el --- Publish -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Łukasz Gruner
;;
;; Author: Łukasz Gruner <lukasz@gruner.lu>
;; Maintainer: Łukasz Gruner <lukasz@gruner.lu>
;; Created: 20-06-2022
;; Modified: 20-06-2022
;; Version: 0.0.1
;; URL: https://github.com/ukaszg/dot
;; Package-Requires: ((emacs "28"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; emacs -Q --batch -l ./publish.el --funcall site-publish
;;
;;; Code:

(require 'package)

;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(setq package-user-dir (expand-file-name "./.packages"))

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Install other dependencies
(use-package htmlize
  :ensure t)

(use-package org
  :ensure t)

(use-package webfeeder
  :ensure t)

(add-to-list 'load-path default-directory)
(require 'site)

(defun site-publish ()
  "Publish the whole site."
  (interactive)
  (org-publish-all t)
  (message "Finished!"))
;;; publish.el ends here
