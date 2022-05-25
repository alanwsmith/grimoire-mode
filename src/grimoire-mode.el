(require 'helm)
(require 'helm-lib)
(require 'helm-utils)

;; (defconst grimoire-mode-base-url
;;   "http://127.0.0.1:7700/indexes/grimoire/"
;;   "This is the base url that is used for calls
;; to meilisearch. It controls both the port and
;; the specific search index that's used")


;; (defconst grimoire-mode-auth-token-file
;;   "/Users/alan/configs/grimoire-mode/meilisearch-token"
;;   "The file to store the melisearch token as a single
;; sting on a single line"
;;   )


;; (defvar grimoire-mode-auth-token
;;   (with-temp-buffer
;;     (insert-file-contents grimoire-mode-auth-token-file)
;;     (string-clean-whitespace
;;      (buffer-string)
;;      )
;;     )
;;   "The search key for meilisearch"
;;   )


;; (defun set-curl-search-command-for-results (query-string)
;;   "The version of the command that gets the full
;; list of items to show in the results"
;;   (concat "curl "
;;           "-s "
;;           "-X "
;;           "POST '"
;;           grimoire-mode-base-url
;;           "search' -H 'Authorization: Bearer "
;;           grimoire-mode-auth-token
;;           "' -H 'Content-Type: application/json' --data-binary '{ \"q\": "
;;           "\"" query-string "\" }'  | jq -r '.hits[] | .filename'"
;;           )
;;   )


(defun grimoire-mode-search-v0.10 ()
  (interactive)
  (helm :sources
        (helm-build-async-source "Grimoire Search"
          :candidates-process
          (lambda ()

            ;; (set-curl-search-command-for-results
            ;;  meilisearch-auth-token
            ;;  helm-pattern)





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
                             "echo 'Running....'")
              )
            )
          )
        :buffer "*helm grimoire search*"
        )
  )



(global-set-key [f5] 'grimoire-mode-search-v0.10)
