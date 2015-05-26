#!/bin/bash

(cd $CONF_HOME/emacs/emacs.d && emacs -q --load "init.el" --script install_dependencies.el)
(cd $CONF_HOME/emacs/emacs.d/nonpackaged && git clone https://github.com/gabrielelanaro/emacs-for-python.git)
