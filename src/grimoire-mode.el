;; Variables

(defconst grimoire-buffer "*Grimoire*"
  "Name of the Grimoire buffer")

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



(defun grimoire-output ()
  (switch-to-buffer grimoire-buffer)
  (insert (grimoire-search))
  )

(defun grimoire-search ()
  (interactive)
  (completing-read
   "Grimoire Search: "
   `(("aexample_1" 1)
     ("beaxmple_2" 2)
     ("ceaxmple_2" 3)
     ("deaxmple_2" 4)
     )
   )
  )



(defun grimoire ()
  "Test to see if this provides grimoire"
  (interactive)
  (switch-to-buffer grimoire-buffer)
  (if (not (eq major-mode 'grimoire-mode))
      (grimoire-mode)
      )
  (grimoire-output)

  )



(provide 'grimoire)
