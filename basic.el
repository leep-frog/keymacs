;; File containing emacs preferences for basic keyboards.

;; C-h as backspace.
(global-set-key (kbd "C-h") 'delete-backward-char)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UNDO CHANGES FROM QMK ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ctrl+h backspace.
(global-set-key [(control ?h)] 'backward-kill-word)

;; un-swap c-f and c-s.
(global-set-key (kbd "C-f" 'forward-char))
(global-set-key (kbd "C-s") 'isearch-forward)
;; Switch C-f to find next occurrence when in search mode.
(define-key isearch-mode-map (kbd "C-s") 'isearch-repeat-forward)
