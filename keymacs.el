;; File containing emacs preferences.

;; The following should be added to your emacs init file (~/.emacs):
;; (add-to-list 'load-path "path/to/keymacs")
;; (load "keymacs")

;; Load things specific to qmk vs basic keyboard
(if (> (length (getenv "EMACS_QMK")) 0) (load "qmk") (load "basic"))

;; SETTINGS.

;; Ignore case when changing files.
(setq read-file-name-completion-ignore-case t)

;; Show line numbers.
(global-linum-mode t)

;; Automatically keep files up to date when other files change them.
(global-auto-revert-mode t)

;; Show column number at the bottom of the screen.
(setq column-number-mode t)

;; Highlight anything over 80 lines.
(setq-default
  whitespace-line-column 80
  whitespace-stype '(face lines-tail))
;; TODO: make this underline things
;;(add-hook 'prog-mode-hook #'whitespace-mode)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

;; If we are using tabs, set the default.
(setq-default tab-width 4)

;; Default to two spaces in java files.
(add-hook 'java-mode-hook (lambda ()
                               (setq c-basic-offiset 2 tab-width 2)))

;; Default to two space tabs in python files.
;; https://dougie.io/emacs/indentation/#changing-the-tab-width
(setq custom-tab-width 2)
(setq-default python-indent-offset custom-tab-width)
(setq-default evil-shift-width custom-tab-width)

;; Default to two spaces in bash files.
(setq-default sh-basic-offset custom-tab-width)

;; Split screen vertically when opening multiple files.
(setq split-heigh-threshold nil)
(setq split-wdith-threshold 0)

;; Move windows directionally.
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

;; Scroll smoothly.
(setq scroll-step           1
      scroll-conservatively 10000)
;; Scroll window up/down by one line.
(global-set-key (kbd "M-n") (kbd "C-u 1 C-v"))
(global-set-key (kbd "M-p") (kbd "C-u 1 M-v"))

;; (server-start)

;; COLORS.

;; TODO: colors based on background.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Font-Lock.html
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Colors.html
;; M-x customize group <RET> font-lock-faces <RET>
;; M-x list-colors-display <RET>
;; To list all faces (https://www.emacswiki.org/emacs/FaceList):
;; M-x list-faces-display

;; Function names.
(set-face-foreground 'font-lock-function-name-face "color-45")
(set-face-attribute 'font-lock-function-name-face nil :bold 'bold)

;; String literals.
(set-face-foreground 'font-lock-string-face "color-171")
(set-face-attribute 'font-lock-string-face nil :bold 'bold)

;; Types.
(set-face-foreground 'font-lock-type-face "color-82")
(set-face-attribute 'font-lock-type-face nil :bold 'bold)

;; Keywords.
(set-face-foreground 'font-lock-keyword-face "color-99")
(set-face-attribute 'font-lock-keyword-face nil :bold 'bold)

;; Mini prompt at bottom (like when changing file).
(set-face-foreground 'minibuffer-prompt "color-51")
(set-face-attribute 'minibuffer-prompt nil :weight 'bold)

;; KEYBOARD CHANGES.

;; Switch file.
(global-set-key (kbd "C-t") 'find-file)
;; Don't like keeping other files open so just explicitly
;; close them and then re-open. Needed for emacs daemon
;; so it doesn't leave some files open forever.
;; TODO: maybe make this eventually keep a stack of at most
;; n files.
(global-set-key (kbd "C-x C-f") (lambda () (interactive)
  (setq b (buffer-name))
  (setq nf (read-file-name "Open file: "))
  (kill-buffer b)
  (find-file nf)
))


;; Line jump.
(global-set-key (kbd "M-l") 'goto-line)
(global-set-key (kbd "C-x C-l") 'goto-line)

;; C-j sets mark for highlighting.
(global-set-key (kbd "C-j") 'set-mark-command)

;; M-v splits screen vertically.
(global-set-key (kbd "M-v") 'split-window-vertically)
(global-set-key (kbd "C-x C-v") 'split-window-vertically)

;; M-v splits screen horizontally.
(global-set-key (kbd "M-z") 'split-window-horizontally)
(global-set-key (kbd "C-x C-h") 'split-window-horizontally)

;; Delete the current window.
(global-set-key (kbd "C-q") 'delete-window)

;; Save buffer. TODO: should this save all buffers?
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-c") 'save-buffers-kill-terminal)

;; SHORTCUTS FOR NON-QMK KEYBOARDS.

;; Jump between windows.
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-u") (lambda () (interactive) (other-window -1)))

;; Jump to top of file. (qmk uses ctrl+home/end)
(global-set-key (kbd "C-x C-p") 'beginning-of-buffer)
(global-set-key (kbd "C-x C-n") 'end-of-buffer)
(global-set-key (kbd "M-p") 'beginning-of-buffer)
(global-set-key (kbd "M-n") 'end-of-buffer)

;; Jump lines in either direction.
(global-set-key (kbd "C-l") 
    (lambda () (interactive) (previous-line 10)))
(global-set-key (kbd "C-v") 
    (lambda () (interactive) (next-line 10)))

;; MACROS.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Basic-Keyboard-Macro.html

;; Start recording macro.
(global-set-key (kbd "M-r") 'kmacro-start-macro-or-insert-counter)
;; End recording or execute last macro.
(global-set-key (kbd "M-e") 'kmacro-end-or-call-macro)

;; CACHED TEXT BLOCKS.

;; Use this format to bind text to a single command.
;; (global-set-key (kbd "M-k") (lambda () (interactive) (insert "hello\nthere")))

;; Use this format to bind text via "M-x alias-name <RET>".
;; (defalias 'heyo (lambda () (interactive) (insert "hello\nthere")))

;; New test function.
;; TODO add arguments for this.
(defalias 'gt (lambda () (interactive) (insert 
"
func TestABC(t *testing.T) {
  for _, test := range []struct {
    name string
  }{
    {
      name: \"test\",
    },
  } {
    t.Run(test.name, func(t *testing.T) {

    })
  }
}
"
)))
