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

(defvar curl-search-command-contents nil
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



(defun grimoire-mode-search-v0.4 ()
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
                     (erase-buffer)
                     (set-curl-search-command-for-contents meilisearch-auth-token helm-pattern)
                     (call-process "/bin/bash" nil "*Grimoire*" nil "-c"
                                    curl-search-command-for-contents
                                    )
                     (start-process "bash" nil "/bin/bash" "-c"
                                    curl-search-command
                                    )
                      )
                     )
                   )
  )
