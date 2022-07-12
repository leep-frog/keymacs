;; File containing emacs preferences for basic keyboards.

;; Don't need to print a message because echo area says "Loading /.../qmk.el"
;; and the focused file banner color changes.

;; Persist basic mode
(if (getenv "EMACS_QMK") (write-region "" nil (getenv "EMACS_QMK")))

;; Set ctrl+x ctrl+t to enable qmk mode.
(global-set-key (kbd "C-x C-t") (lambda () (interactive) (load "qmk")))

;;;;;;;;;;;;;;;;;;;;;;;;
;; BASIC KEY BINDINGS ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; C-h as backspace.
(global-set-key (kbd "C-h") 'delete-backward-char)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; STYLE SPECIFIC TO BASIC ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ACTIVE WINDOW
;; Section populapted from https://emacs.stackexchange.com/questions/24630/is-there-a-way-to-change-color-of-active-windows-fringe

;; Use different colors of mode line for the active and inactive windows:
(custom-set-faces
 '(mode-line ((t (:background "color-28" :foreground "white"))))
 '(mode-line-inactive ((t (:background "white" :foreground "color-232")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UNDO CHANGES FROM QMK ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Backspace character as backspace (not backspace word).
(global-set-key [(control ?h)] 'delete-backward-char)

;; un-swap c-f and c-s.
(global-set-key (kbd "C-f") 'forward-char)
(global-set-key (kbd "C-s") 'isearch-forward)
;; Switch C-f to find next occurrence when in search mode.
(define-key isearch-mode-map (kbd "C-s") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-f") nil)
(if (and (getenv "EMACS_QMK") (file-exists-p (getenv "EMACS_QMK"))) (delete-file (getenv "EMACS_QMK")))
