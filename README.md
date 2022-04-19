# Keymacs

Keymacs contains an emacs profile for alternating use of a regular keyboard and a QMK keyboard.

## Set up

Add the following to your emacs init file (`~/.emacs`):

```lisp
(add-to-list 'load-path "path/to/keymacs")
(load "keymacs")
```

Add the following to your bash profile:

```bash
# File used to check if we are in basic or QMK mode.
export EMACS_QMK="/home/gleep/.emacs/leep-qmk-mode.txt"
# If you would like a bash command (`eq`) to toggle between
# basic and QMK mode, add the following to your bash profile:
source /path/to/keymacs/source.sh
```

## Useful Commands

### Macros
 
 - `M-r`: start recording macro

 - `M-e`: End recording or call macro