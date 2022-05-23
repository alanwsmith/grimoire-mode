;; This version works for the basic pull but
;; doesn't update the main window

(defconst grimoire-buffer "*Grimoire*"
  "Name of the Grimoire buffer")


(defvar meilisearch-auth-token nil 
  "The search key for meilisearch"
  )

(defvar curl-search-command-for-resutls nil
  "The curl command used to query meilisearch"
  )

(defvar curl-search-command-for-contents nil
  "For getting the contents for the top result"
  )

(defun file-to-string (file)
  "Read a file into a string"
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)
    )
  )

(defun set-curl-search-command-for-contents (
                                             auth-token
                                             query-string)
  "Build the curl command to get the content
for the top search result"

  (setq curl-search-command-for-contents
        (concat "curl -s -X POST 'http://127.0.0.1:7575/indexes/movies/search' -H 'Authorization: Bearer " 
                auth-token
                "' -H 'Content-Type: application/json' --data-binary '{ \"q\": "
                "\"" query-string "\" }'  | jq -r '.hits[0] | .overview'"
                )
        )
  )



(defun set-curl-search-command-for-results (
                                            auth-token
                                            query-string)
  "The version of the command that gets the full
list of items to show in the results"

  (setq curl-search-command-for-results
        (concat "curl -s -X POST 'http://127.0.0.1:7575/indexes/movies/search' -H 'Authorization: Bearer " 
                auth-token
                "' -H 'Content-Type: application/json' --data-binary '{ \"q\": "
                "\"" query-string "\" }'  | jq -r '.hits[] | .title'"
                )
        )
  )



(defvar helm-buffer-line nil
  "The line of the helm buffer")

(defun post-line-move-hook ()
  (switch-to-buffer helm-buffer)
  (setq helm-buffer-line (with-current-buffer helm-buffer (format-mode-line "%l")))

  (switch-to-buffer grimoire-buffer)

  ;; (insert (format-mode-line "%l"))
  ;; (insert "\n")
  ;; (insert (format-mode-line "%l"))
  ;; (insert "\n")
  ;; (insert helm-buffer)

  (insert "\n")
  (insert helm-buffer-line)

  ; (insert (with-current-buffer helm-buffer (format-mode-line "%l")))


  )

(setq helm-move-selection-after-hook 'post-line-move-hook)


(defun grimoire-mode-search-v0.5 ()
  "This version makes two calls to the meilisearch search
the first one returns the data for the file and the second one
returns the next list of candidates"
  (setq meilisearch-auth-token
        (string-clean-whitespace
         (file-to-string "/Users/alan/configs/grimoire-mode/meilisearch-token")
         )
        )

  (interactive)

  (switch-to-buffer grimoire-buffer)

  (erase-buffer)

  (helm :sources
        (helm-build-async-source "aws-helm-source"
          :candidates-process
          (lambda ()

            (switch-to-buffer grimoire-buffer)

            (erase-buffer)

            (set-curl-search-command-for-contents
             meilisearch-auth-token
             helm-pattern)

            (set-curl-search-command-for-results
             meilisearch-auth-token
             helm-pattern)

            (insert helm-buffer)

            ;; This first call updates the contents buffer
            (call-process "/bin/bash" nil "*Grimoire*" nil "-c"
                          curl-search-command-for-contents
                          )


            ;; This call gets the list of results to
            ;; set as the next list of candidates
            (start-process "bash" nil "/bin/bash" "-c"
                           curl-search-command-for-results
                           )
            )
          )
        )
  )
