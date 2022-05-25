;; This is the main grimoire file


(defconst grimoire-mode-base-url
  "http://127.0.0.1:7700/indexes/grimoire/"
  "This is the base url that is used for calls
to meilisearch. It controls both the port and
the specific search index that's used")

(defconst grimoire-mode-buffer "*Grimoire*"
  "Name of the Grimoire buffer")

(defvar meilisearch-auth-token nil 
  "The search key for meilisearch")

(defvar curl-search-command-for-resutls nil
  "The curl command used to query meilisearch")

(defvar curl-search-command-for-contents nil
  "For getting the contents for the top result")

(defun file-to-string (file)
  "Read a file into a string"
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)
    )
  )

(defun set-curl-search-command-for-contents (
                                             auth-token
                                             query-string
                                             index)
  "Build the curl command to get the content
for the top search result"

  (setq curl-search-command-for-contents
        (concat "curl -s -X POST '" grimoire-mode-base-url "search' -H 'Authorization: Bearer "
                auth-token
                "' -H 'Content-Type: application/json' --data-binary '{ \"q\": "
                "\"" query-string "\" }'  | jq -r '.hits[" index "] | .content'"
                )
        )
  )


(defun set-curl-search-command-for-results (
                                            auth-token
                                            query-string)
  "The version of the command that gets the full
list of items to show in the results"

  (setq curl-search-command-for-results
        (concat "curl -s -X POST '" grimoire-mode-base-url "search' -H 'Authorization: Bearer "
                auth-token
                "' -H 'Content-Type: application/json' --data-binary '{ \"q\": "
                "\"" query-string "\" }'  | jq -r '.hits[] | .filename'"
                )
        )
  )


(defvar helm-buffer-line nil
  "The line of the helm buffer")

(defun post-line-move-hook ()
  (switch-to-buffer helm-buffer)
  (setq helm-buffer-line
        (with-current-buffer helm-buffer (string-to-number (format-mode-line "%l")))
        )

  (setq helm-buffer-line (- helm-buffer-line 2))

  (switch-to-buffer grimoire-mode-buffer)
  (erase-buffer)

  (set-curl-search-command-for-contents
   meilisearch-auth-token
   helm-pattern
   (number-to-string helm-buffer-line)
   )

  ;; This first call updates the contents buffer
  (call-process "/bin/bash" nil "*Grimoire*" nil "-c"
                curl-search-command-for-contents
                )
  )


;; Load the meilisearch key
;; This could probably be moved out so it just runs once
(setq meilisearch-auth-token
      (string-clean-whitespace
       (file-to-string
        "/Users/alan/configs/grimoire-mode/meilisearch-token")
       )
      )


(defun grimoire-mode-load-content ()
  (switch-to-buffer grimoire-mode-buffer)
  (if (string= helm-pattern "")
      (insert "-- Grimoire Mode --")

    ;; This first call updates the contents buffer
    (call-process "/bin/bash" nil "*Grimoire*" nil "-c"
                  curl-search-command-for-contents
                  )
    )
  (goto-char(point-min))

  )


(defun grimoire-mode-handle-result (return-value)
  "This is what handles the resturn value from the call"
  (setq helm-move-selection-after-hook nil)
  (message (concat "Value: " return-value))
  (if (string= return-value "Ready...")
      (message "No file selected")
    (progn
      (message (concat "Loading: " return-value) )
      (find-file (concat "/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Grimoire/" return-value))
      (org-mode)
      )
      )
  (kill-buffer grimoire-mode-buffer)
  )

(defun grimoire-mode-search-v0.6 ()
  "This version makes two calls to the meilisearch search
the first one returns the data for the file and the second one
returns the next list of candidates"

  (interactive)

  (switch-to-buffer grimoire-mode-buffer)

  ;; Setup the hook for catching update via arrow keys
  (setq helm-move-selection-after-hook 'post-line-move-hook)

  ;; TODO: unset this when leaving the grimoire

  (switch-to-buffer grimoire-mode-buffer)

  (erase-buffer)

  (grimoire-mode-handle-result (helm :sources
        (helm-build-async-source "aws-helm-source"
          :candidates-process
          (lambda ()
            (switch-to-buffer grimoire-mode-buffer)
            (erase-buffer)
            (set-curl-search-command-for-contents
             meilisearch-auth-token
             helm-pattern
             "0")
            (set-curl-search-command-for-results
             meilisearch-auth-token
             helm-pattern)
            (grimoire-mode-load-content)
            (if (string= helm-pattern "")
                (start-process "bash"
                               nil
                               "/bin/bash"
                               "-c"
                               "echo 'Ready...'")
              (start-process "bash"
                             nil
                             "/bin/bash"
                             "-c"
                             curl-search-command-for-results)
              )
            )
          )
        :buffer "*helm grimoire search*"
        )
                               )
  )


(defun grimoire-mode-update-index ()
  "Function to run the update script"
  (message "Updating Index")
  (start-process "uploader"
                 nil
                 "/opt/homebrew/bin/python3"
                 "/Users/alan/workshop/grimoire-mode/meilisearch-utils/update.py"
                 )
  )

;; TODO: Set this up so it's only org mode probably
(add-hook 'after-save-hook
          'grimoire-mode-update-index
          )

;; (defun post-save-test ()
;;   (with-current-buffer "*scratch*"
;;     (insert "ping")
;;     )
;;   )
;; (add-hook 'after-save-hook 'post-save-test)

(global-set-key [f5] 'grimoire-mode-search-v0.6)

