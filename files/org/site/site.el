;;; site.el --- My static site -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Łukasz Gruner
;;
;; Author: Łukasz Gruner <lukasz@gruner.lu>
;; Maintainer: Łukasz Gruner <lukasz@gruner.lu>
;; Created: 17-06-2022
;; Modified: 20-08-2022
;; Version: 0.0.1
;; URL: https://github.com/ukaszg/dot
;; Package-Requires: ((emacs "28.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  My static site
;;
;;; Todo:
;; - Generating blog index
;; - Generating rss
;; - preamble
;;
;;; Code:

(require 'org)
(require 'ox-publish)
(require 'ox-org)
(require 'ox-html)
(require 'ob-tangle)
(require 's)

(defconst site-setupfile (file-truename "./setupfile.org")
  "Default setupfile for generated org files.")

(defun site--get-title ()
  "Return page title for the current entry."
  (let ((case-fold-search t))
    (save-excursion
      (beginning-of-line)
      (save-match-data
        (when (looking-at org-complex-heading-regexp)
          (match-string 4))))))

(defun site--get-url ()
  "Return dirname from title."
  (s-downcase
   (save-match-data
     (replace-regexp-in-string
      "[^A-Za-z0-9]" "_" (site--get-title)))))

(defun site--export-subtree-as-org (dir &optional page-title path setupfile subtreep)
  "Export subtree under point as an org file under `DIR'."
  (save-excursion
    (let ((title      (or page-title (site--get-title)))
          (full-path  (file-truename (if path (expand-file-name path dir) dir)))
          (setup-full (file-truename (or setupfile site-setupfile)))
          org-export-show-temporary-export-buffer)
      (unless subtreep (org-narrow-to-subtree))
      (org-org-export-as-org nil subtreep)
      (unless subtreep (widen))
      (with-current-buffer "*Org ORG Export*"
        (goto-char (point-min))
        (insert (format "#+SETUPFILE: %s\n" setup-full))
        (insert (format "#+TITLE: %s\n" title))
        (insert "\n")
        (setq buffer-file-name (expand-file-name "index.org" full-path))
        (basic-save-buffer)
        (kill-buffer)))))

(defun site-preparation-function-html (props)
  "Exports a subtrees under toplevel elements named 'LANDING',
'STATIC' and 'BLOG' as org files.
Requires a :file and :base-directory properties
present to know source file and directory to write to."
  (let* ((file (or (file-truename (plist-get props :file))
                   (error "No property :file")))
         (base (or (file-truename (plist-get props :base-directory))
                   (error "No property :directory")))
         (buff (or (org-find-base-buffer-visiting file)
                   (find-file-noselect file)
                   (error "No such file %s" file)))
         title)
    (save-excursion
      (with-current-buffer buff
        (setq title (cadar (org-collect-keywords '("TITLE"))))
        (widen)
        (org-show-all)
        (save-match-data
          (goto-char (point-min))
          (when (re-search-forward "^\* LANDING" nil t)
            (site--export-subtree-as-org base title nil nil t))
          (goto-char (point-min))
          (when (re-search-forward "^\* STATIC" nil t)
            (let ((cur-point (point)))
              (org-next-visible-heading 1) ;; go inside
              (while (not (eq (point) cur-point))
                (site--export-subtree-as-org
                 base nil (site--get-url) nil t)
                (setq cur-point (point))
                (org-forward-heading-same-level 1 t))))
          (goto-char (point-min))
          (when (re-search-forward "^\* BLOG" nil t)
            (let ((cur-point (point))
                  url
                  articles)
              (org-next-visible-heading 1) ;; go inside
              (while (not (eq (point) cur-point))
                (setq url (format "./blog/%s/" (site--get-url)))
                (site--export-subtree-as-org base nil url)
                (push (list :url url
                            :title (site--get-title)
                            :date (org-entry-get nil "CREATED"))
                      articles)
                (setq cur-point (point))
                (org-forward-heading-same-level 1 t))
              (setq articles
                    ;; TODO: Parse date and sort by that.
                    ;; Currently this relies on the fact that my date format is sortable alphabetically.
                    (sort articles (lambda (first second)
                                     (string< (plist-get first :date)
                                              (plist-get second :date)))))
              (let ((f (expand-file-name "blog/index.org" base)))
                (with-temp-buffer
                  (insert (format "#+SETUPFILE: %s\n" site-setupfile))
                  (insert (format "#+TITLE: %s: Blog\n" title))
                  (insert "\n")
                  (mapc (lambda (e)
                          (insert (format "* [[%s][%s]]\n:PROPERTIES:\n:CREATED: %s\n:END:\n\n"
                                          (plist-get e :url)
                                          (plist-get e :title)
                                          (plist-get e :date))))
                        articles)
                  (setq buffer-file-name f)
                  (basic-save-buffer))))))))))

(defun site-preparation-function-css (props)
  "Tangles css file from toplevel subtree named 'CSS'.
Requires a :file and :base-directory properties
present to know source file and directory to write to."
  (let* ((file (or (file-truename (plist-get props :file))
                   (error "No property :file")))
         (base (expand-file-name
                "style.css"
                (or (file-truename (plist-get props :base-directory))
                    (error "No property :base-directory"))))
         (buff (or (org-find-base-buffer-visiting file)
                   (find-file-noselect file)
                   (error "No such file %s" file))))
    (save-excursion
      (with-current-buffer buff
        (goto-char (point-min))
        (save-match-data
          (when (re-search-forward "^\* CSS" nil t)
            (org-narrow-to-subtree)
            (org-babel-tangle nil base "css")
            (widen)))))))

(let ((pub-dir (file-truename "./_out/kasz"))
      (src-dir (file-truename "./"))
      (tmp-dir (make-temp-file "site" t)))
  (setq org-publish-project-alist
        `(("css"
           :base-directory ,tmp-dir
           :publishing-directory ,pub-dir
           :publishing-function org-publish-attachment
           :exclude-tags ("disabled")
           :file ,(expand-file-name "main.org" src-dir)
           :preparation-function site-preparation-function-css
           :include ("style.css")
           :exclude ".*")
          ("static"
           :base-directory ,src-dir
           :publishing-directory ,pub-dir
           :publishing-function org-publish-attachment
           :include ("favicon.ico" "terminus.woff2")
           :exclude ".*")
          ("site"
           :base-directory ,tmp-dir
           :publishing-directory ,pub-dir
           :publishing-function org-html-publish-to-html
           :recursive t
           :exclude-tags ("disabled")
           :file ,(expand-file-name "main.org" src-dir)
           :preparation-function site-preparation-function-html)
          ("everything"
           :components ("css" "static" "site")))))

(provide 'site)
;; -*- coding: utf-8-emacs; -*-
;;; site.el ends here
