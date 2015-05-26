#!/bin/bash

(cd emacs.d && emacs --script -q --load "init.el" install_dependencies.el)
(cd emacs.d/nonpackaged && git clone https://github.com/gabrielelanaro/emacs-for-python.git)
