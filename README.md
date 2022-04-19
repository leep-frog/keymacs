# Keymacs

Keymacs contains an emacs profile for alternating use of a regular keyboard and a QMK keyboard.

## Set up

Add the following to your emacs init file (`~/.emacs`):

```lisp
(add-to-list 'load-path "path/to/keymacs")
(load "keymacs")
```

If you would like a bash command (`eq`) to toggle between basic and QMK mode, add the following to your bash profile:

```bash
source /path/to/keymacs/source.sh
```

## Useful Commands

### Macros
 
 - `M-r`: start recording macro

 - `M-e`: End recording or call macro