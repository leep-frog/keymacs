;; File containing emacs preferences.

;; Load things specific to qmk vs basic keyboard
(if (and (getenv "EMACS_QMK") (file-exists-p (getenv "EMACS_QMK"))) (load "qmk") (load "basic"))

;; Reload keymacs
(defalias 'keyload (lambda () (interactive) (load "keymacs")))

;; SETTINGS.

;; Ignore case when changing files.
(setq read-file-name-completion-ignore-case t)

;; Empty scratch buffer.
(setq initial-scratch-message nil)

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
(set-face-foreground 'font-lock-string-face "color-208")

;; Types.
(set-face-foreground 'font-lock-type-face "color-82")
(set-face-attribute 'font-lock-type-face nil :bold 'bold)

;; Keywords.
(set-face-foreground 'font-lock-keyword-face "color-177")
(set-face-attribute 'font-lock-keyword-face nil :bold 'bold)

;; Mini prompt at bottom (like when changing file).
(set-face-foreground 'minibuffer-prompt "color-51")
(set-face-attribute 'minibuffer-prompt nil :weight 'bold)

;; Line numbers.
(set-face-foreground 'linum "color-87")
(set-face-background 'linum "color-238")

;; Format of line numbers. Copied and slightly modified from
;; https://www.emacswiki.org/emacs/LineNumbers
(unless window-system
  (add-hook 'linum-before-numbering-hook
	    (lambda ()
	      (setq-local linum-format-fmt
			  (let ((w (length (number-to-string
					    (count-lines (point-min) (point-max))))))
			    (concat " %" (number-to-string w) "d "))))))

(defun linum-format-func (line)
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)))

(unless window-system
  (setq linum-format 'linum-format-func))

;; Comments
(set-face-foreground 'font-lock-comment-face "brightgreen")

;; ACTIVE WINDOW
;; Highlight the current line where the point is in active window:
(global-hl-line-mode 1)
;; Set highlight color.
(set-face-background 'highlight "color-236")
;; Underline the current line.
(set-face-attribute hl-line-face nil :underline t)

;; KEYBOARD CHANGES.

;; Switch file.
;; Switch to file, but save the current file before doing so.
(defun open-file (allow-new) (progn
  (setq b (buffer-name))
  (setq nf (read-file-name "Open file: "))
  (if (or allow-new (file-exists-p nf)) (progn (find-file nf) (save-buffer b) (find-file nf)) (error "File does not exist. Use C-t to create a new file"))
))

;; Open an existing file
(global-set-key (kbd "C-x C-f") (lambda () (interactive) (open-file nil)))
;; Open a new or existing file.
(global-set-key (kbd "C-t") (lambda () (interactive) (open-file t)))

;; Line jump.
(global-set-key (kbd "M-l") 'goto-line)
(global-set-key (kbd "C-x C-l") 'goto-line)

;; C-j sets mark for highlighting.
(global-set-key (kbd "C-j") 'set-mark-command)

;; M-v splits screen vertically.
(global-set-key (kbd "M-v") 'split-window-vertically)
(global-set-key (kbd "C-x C-v") 'split-window-vertically)
(global-set-key (kbd "C-x <xterm-paste>") 'split-window-vertically)

;; M-v splits screen horizontally.
(global-set-key (kbd "M-z") 'split-window-horizontally)
(global-set-key (kbd "C-x C-h") 'split-window-horizontally)

;; Save buffer and delete the current window.
(global-set-key (kbd "C-q") (lambda () (interactive)
  (save-buffer (buffer-name))
  (delete-window)
))

;; Save buffer. TODO: should this save all buffers?
(global-set-key (kbd "M-c") 'save-buffers-kill-terminal)

;; Jump between windows.
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-u") (lambda () (interactive) (other-window -1)))

;; Jump to top of file. (qmk uses ctrl+home/end)
(global-set-key (kbd "C-x C-p") 'beginning-of-buffer)
(global-set-key (kbd "C-x C-n") 'end-of-buffer)
(global-set-key (kbd "M-p") 'beginning-of-buffer)
(global-set-key (kbd "M-n") 'end-of-buffer)
;; Needed for qmk shift layer.
(global-set-key (kbd "M-P") 'beginning-of-buffer)
(global-set-key (kbd "M-N") 'end-of-buffer)
;; Needed for qmk shift layer.
(global-set-key (kbd "C-x M-p") 'beginning-of-buffer)
(global-set-key (kbd "C-x M-n") 'end-of-buffer)
;; Needed for qmk shift layer.
(global-set-key (kbd "C-x M-P") 'beginning-of-buffer)
(global-set-key (kbd "C-x M-N") 'end-of-buffer)

;; Needed for qmk shift layer.
(global-set-key (kbd "C-A") 'beginning-of-line)
(global-set-key (kbd "C-E") 'end-of-line)

;; Jump lines in either direction.
(global-set-key (kbd "C-l") 
    (lambda () (interactive) (previous-line 10)))
(global-set-key (kbd "C-v") 
    (lambda () (interactive) (next-line 10)))
;; Needed for qmk shift layer.
(global-set-key (kbd "C-L") 
    (lambda () (interactive) (previous-line 10)))
(global-set-key (kbd "C-V") 
    (lambda () (interactive) (next-line 10)))

;; Find and replace.
(global-set-key (kbd "M-s") 'query-replace)

;; MACROS.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Basic-Keyboard-Macro.html

;; Create go map.
;; TODO: Change behavior depending on file type.
(global-set-key (kbd "M-g M-m") (lambda () (interactive)
  (setq input (read-string "List of map parts: "))
  (setq parts (split-string input))
  (setq value (nth (1- (length parts)) parts))
  (setq parts (butlast parts 1))
  (insert (concat "map[" (mapconcat 'identity parts "]map[")) "]" value "{")
))

;; Start recording macro.
;;(global-set-key (kbd "M-r") 'kmacro-start-macro-or-insert-counter)
(global-set-key (kbd "M-r") 'kmacro-start-macro)
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
