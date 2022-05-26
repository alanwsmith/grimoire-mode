(require 'helm)
(require 'helm-lib)
(require 'helm-utils)

(defconst grimoire-mode-buffer "*Grimoire*"
  "Name of the Grimoire buffer")

(defvar grimoire-mode-helm-buffer-line 0
  "Storage for the current line position of
the helm buffer")

(defvar grimiore-mode-helm-buffer-line-adjusted 0
  "Adjusted to accont for the fact the results
start on the second line")

(defun grimoire-mode-handle-selection (return-value)
  (message return-value)
  (if (string= return-value "Ready...")
      (message "No file selected.")
    (progn
      (message (concat "Loading: " return-value) )
      (find-file(concat "/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Grimoire/" return-value))
      (org-mode)
      )))

(defun grimiore-mode-update-preview ()
  (setq grimoire-mode-helm-buffer-line
        (with-current-buffer helm-buffer (string-to-number (format-mode-line "%l"))))
  (setq grimoire-mode-helm-buffer-line-adjusted
        (max (- grimoire-mode-helm-buffer-line 2) 0) )
  (message (number-to-string grimoire-mode-helm-buffer-line))
  (switch-to-buffer grimoire-mode-buffer)
  (erase-buffer)
  (if (string= helm-pattern "")
      (insert "-- Grimoire Mode --")
    (call-process
   "/bin/bash"
   nil
   grimoire-mode-buffer
   nil
   "get-search-content"
   helm-pattern
   (number-to-string grimoire-mode-helm-buffer-line-adjusted)))
  (goto-char (point-min)))


(defun grimoire-mode-search-v0.10 ()
  (interactive)
  (setq helm-move-selection-after-hook 'grimiore-mode-update-preview)
  (switch-to-buffer grimoire-mode-buffer)
  (org-mode)
  (grimoire-mode-handle-selection(helm :sources
        (helm-build-async-source "Grimoire Search"
          :candidates-process
          (lambda ()
            (grimiore-mode-update-preview)
            (start-process "search" nil "/bin/bash" "get-search-results" helm-pattern)))
        :buffer "*helm grimoire search*"))
  (setq helm-move-selection-after-hook nil)
  (kill-buffer grimoire-mode-buffer))

(global-set-key [f5] 'grimoire-mode-search-v0.10)
