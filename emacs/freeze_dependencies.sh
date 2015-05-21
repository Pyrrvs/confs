#!/bin/bash
find emacs.d/elpa/ -maxdepth 1 -type d | grep '-' | cut -d '/' -f 3 | rev | cut -d '-' -f 2- | rev > emacs.d/emacs_requirements.txt
