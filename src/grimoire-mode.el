(require 'helm)
(require 'helm-lib)
(require 'helm-utils)

;; NOTE: I think this needs to be set in the custom
;; config section of the spacemacs config:
;; '(idle-update-delay 0.1)

;; See .spacemacs for setting grimoire-mode-directory
;; and grimoire-mode-get-search-results-script

(defconst grimoire-mode-buffer "*Grimoire*"
  "Name of the Grimoire buffer")

(defun grimoire-mode-handle-selection (selection)
  (unless (string= selection nil)
    (unless (string= selection "Ready...")
      (progn
        (find-file(concat grimoire-mode-directory "/" selection))
        (org-mode)
        )
      )
    )
  )

(defun grimiore-mode-handle-preview (candidate)
  (if (string= candidate "Ready...")
      (progn
        (switch-to-buffer grimoire-mode-buffer)
        (erase-buffer)
        )
    (progn
      (switch-to-buffer grimoire-mode-buffer)
      (erase-buffer)
      (find-file(concat grimoire-mode-directory "/" candidate))
      (insert-into-buffer grimoire-mode-buffer)
      (unless (buffer-modified-p)
        (kill-buffer (current-buffer))
        )
      (goto-char (point-min))
      (org-mode)
    )
    )
  )

(defun grimoire-mode-search ()
  (interactive)
  (grimoire-mode-handle-selection(helm :sources
        (helm-build-async-source "Grimoire Search"
          :follow 1
          :follow-delay 0.001
          :persistent-action 'grimiore-mode-handle-preview
          :candidates-process
          (lambda ()
            (start-process
             "search"
             nil
             "/opt/homebrew/bin/python3"
             grimoire-mode-get-search-results-script
             helm-pattern)))
        :buffer "*helm grimoire search*"))
  (kill-buffer grimoire-mode-buffer))

