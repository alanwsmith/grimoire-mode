(defvar grimoire-mode-hook nil
  "*Add funcitons here*")

(defun grimoire-mode ()
  "Major mode for the an Org Mode Grimoire"
  (message "Initializing Grimoire")
  (kill-all-local-variables)
  (setq major-mode 'grimoire-mode)
  (setq mode-name "Grimoire")
  (run-hooks 'grimoire-mode-hook)


