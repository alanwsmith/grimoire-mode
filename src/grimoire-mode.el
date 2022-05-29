(require 'helm)
(require 'helm-lib)
(require 'helm-utils)

;; See .spacemacs for setting grimoire-mode-directory

(defconst grimoire-mode-buffer "*Grimoire*"
  "Name of the Grimoire buffer")

(defvar grimoire-mode-get-search-results-script
  "/Users/alan/workshop/grimoire-mode/src/get-search-results"
  "Path to the script that returns the content to populate the
results in the grimoire"
  )

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
      (kill-buffer (current-buffer))
      (goto-char (point-min))
      (org-mode)
    )
    )
  )

(defun grimoire-mode-search-v0.10 ()
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
             "/bin/bash"
             grimoire-mode-get-search-results-script
             helm-pattern)))
        :buffer "*helm grimoire search*"))
  (kill-buffer grimoire-mode-buffer))

