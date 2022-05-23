;; This version works for the basic pull but
;; doesn't update the main window

(defconst grimoire-buffer "*Grimoire*"
  "Name of the Grimoire buffer")


(defvar meilisearch-auth-token nil 
  "The search key for meilisearch"
  )

(defvar curl-search-command nil
  "The curl command used to query meilisearch"
  )

(defun file-to-string (file)
  "Read a file into a string"
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)
    )
  )

(defun grimoire-mode-search-v0.3 ()
  "This uses start-process which gets the list
But I haven't figure out how to get it to update the
text area too. Might be able to do it by passing to
a function which builds an does the query and updates
the main window then writes a list of candidates to
a file that gets pulled back in via a new process.
Would bascially be running two things, but it might work.
Gonna try using 'volatile' in a basic 'helm-source' instead
"
  (setq meilisearch-auth-token
        (string-clean-whitespace
         (file-to-string "/Users/alan/configs/grimoire-mode/meilisearch-token")
        )
        )
  (interactive)
  (switch-to-buffer grimoire-buffer)
  (insert
   (helm :sources (helm-build-async-source "aws-helm-source"
                   :candidates-process
                   (lambda ()
                     (setq curl-search-command
                           (concat "curl -s -X POST 'http://127.0.0.1:7575/indexes/movies/search' -H 'Authorization: Bearer " 
                                   meilisearch-auth-token
                                   "' -H 'Content-Type: application/json' --data-binary '{ \"q\": "
                                   "\"" helm-pattern  "\" }'  | jq -r '.hits[] | .title'"
                                   )
                           )
                     (switch-to-buffer grimoire-buffer)
                     (start-process "bash" nil "/bin/bash" "-c"
                                    curl-search-command
                                    )
                      )
                     )
                   ))
  )
