#!/bin/sh
exec emacs -Q --batch -l ./publish.el --funcall site-publish
