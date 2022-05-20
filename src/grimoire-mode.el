;; Variables

(defconst grimoire-buffer "*Grimoire*"
  "Name of the Grimoire buffer")

(defvar grimoire-file-list nil
  "The list of files to display")

;; Functions

;; (defun grimoire-print-header ()
;;   (insert "Grimoire\n\n")
;;   )


;; Framework

(defvar grimoire-mode-hook nil
  "Grimoire Hook"
  )

(defun grimoire-mode ()
  "Major mode for the an Org Mode Grimoire"
  (message "Initializing Grimoire")
  (kill-all-local-variables)
  (setq major-mode 'grimoire-mode)
  (setq mode-name "Grimoire")
  (run-hooks 'grimoire-mode-hook))

(put 'grimoire-mode 'mode-class 'special)

(defun grimoire ()
  "Test to see if this provides grimoire"
  (interactive)
  (if (not (eq major-mode 'grimoire-mode))
      (grimoire-mode)
      )
  )



(provide 'grimoire)
