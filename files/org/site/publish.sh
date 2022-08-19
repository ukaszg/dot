#!/bin/sh
yes | emacs -Q --batch -l ./publish.el --funcall site-publish
