(require 'helm)
(require 'helm-lib)
(require 'helm-utils)

;; See .spacemacs for setting grimoire-mode-directory

(defconst grimoire-mode-buffer "*Grimoire*"
  "Name of the Grimoire buffer")

(defvar grimoire-mode-helm-buffer-line 0
  "Storage for the current line position of
the helm buffer")

(defvar grimoire-mode-helm-buffer-line-adjusted 0
  "Adjusted to accont for the fact the results
start on the second line")

(defvar grimoire-mode-get-search-content-script
  "/Users/alan/workshop/grimoire-mode/src/get-search-content"
  "Path to the script that returns the content to populate
the grimoire preview"
  )

(defvar grimoire-mode-get-search-results-script
  "/Users/alan/workshop/grimoire-mode/src/get-search-results"
  "Path to the script that returns the content to populate the
results in the grimoire"
  )

;; (defun grimiore-mode-test (candidate)
;;   (switch-to-buffer grimoire-mode-buffer)
;;   (if (string= candidate "Ready...")
;;       (message "No file selected.")
;;     (find-file(concat grimoire-mode-directory "/" candidate))
;;   )
;;   )

(defun grimoire-mode-handle-selection (return-value)

  ;; ;; (message return-value)
  ;; (if (string= return-value nil)
  ;;     (message "No file selected.")
  ;; (if (string= return-value "Ready...")
  ;;     (message "No file selected.")
  ;;   (progn
  ;;     (message (concat "Loading: " return-value) )
  ;;     (find-file(concat grimoire-mode-directory "/" return-value))
  ;;     (org-mode)
  ;;     )))


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

