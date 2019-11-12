;;; dired-hide-permissions.el --- Hides permissions block in dired buffers.

(define-minor-mode dired-hide-permissions-mode
  "Toggle visibility of the permission flags in current Direct buffer."
  nil nil nil
  (unless (derived-mode-p 'dired-mode)
    (error "Not a Dired buffer"))
  (dired-hide-permissions-maybe))

(defun dired-hide-permissions-maybe()
  (let ((inhibit-read-only t))
    (save-excursion
      (goto-char (point-min))
      (while (< (point) (point-max))
        (if (search-forward-regexp dired-re-perms (line-end-position) t)
            (if dired-hide-permissions-mode
                (put-text-property (match-beginning 0) (match-end 0) 'display "")
              (remove-text-properties (match-beginning 0) (match-end 0) '(display nil))))
        (forward-line 1)))))

(defun dired-hide-permissions-mode-always()
  (interactive)
  (add-hook 'dired-mode-hook
            'dired-hide-permissions-mode))

(defun dired-hide-permissions-mode-never()
  (interactive)
  (remove-hook 'dired-mode-hook
            'dired-hide-permissions-mode))

(add-hook
 'dired-after-readin-hook
 'dired-hide-permissions-maybe t)
          
