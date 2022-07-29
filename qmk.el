;; File containing emacs preferences specific to QMK keyboard.

;; Don't need to print a message because echo area says "Loading /.../qmk.el"
;; and the focused file banner color changes.

;; Persist QMK mode
(if (and (getenv "EMACS_QMK") (file-exists-p (getenv "EMACS_QMK"))) (delete-file (getenv "EMACS_QMK")))

;; Set ctrl+x ctrl+t to enable basic mode.
(global-set-key (kbd "C-x C-k") (lambda () (interactive) (load "basic")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; STYLE SPECIFIC TO QMK ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ACTIVE WINDOW
;; Section populapted from https://emacs.stackexchange.com/questions/24630/is-there-a-way-to-change-color-of-active-windows-fringe

;; Use different colors of mode line for the active and inactive windows:
(custom-set-faces
 '(mode-line ((t (:background "color-27" :foreground "white"))))
 '(mode-line-inactive ((t (:background "white" :foreground "color-232")))))

;;;;;;;;;;;;;;;;;;;;;;
;; QMK KEY BINDINGS ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Backspace an entire word
;; This allows backward kill word to work in chrome, emacs, and regular terminal.
;; "?h" is the code sent by the backspace character, btw.
;; Ctrl-backspace and ctrl-h are the same in emacs. QMK runs Ctrl-backspace and Ctrl-Alt-H,
;; so we make one of those a no-op and the other backward-kill-word.
(global-set-key [(control ?h)] 'backward-kill-word)
(global-set-key [(control meta ?h)] (lambda () (interactive) ()))

;; Jump between windows. (next is PageUp and prior is PageDown).
;; QMK uses PageUp and PageDown so switching tabs is equivalent in Chrome and emacs.
(global-set-key (kbd "<C-next>") 'other-window)
(global-set-key (kbd "<C-prior>") (lambda () (interactive) (other-window -1)))

;; Jump 10 lines with page up and page down (C-v and C-l on qmk keyboard).
(global-set-key (kbd "<prior>") 
    (lambda () (interactive) (previous-line 10)))
(global-set-key (kbd "<next>") 
    (lambda () (interactive) (next-line 10)))

;; Switch search to C-f.
(global-set-key (kbd "C-f") 'isearch-forward)
;; Switch C-f to find next occurrence when in search mode.
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
(if (getenv "EMACS_QMK") (append-to-file "" nil (getenv "EMACS_QMK")))
