;; Variables

(defconst grimoire-buffer "*Grimoire*"
  "Name of the Grimoire buffer")

;; Framework

;; (defvar grimoire-mode-hook nil
;;   "Grimoire Hook"
;;   )

;; (defun grimoire-mode ()
;;   "Major mode for the an Org Mode Grimoire"
;;   ; (selectrum-mode +1)
;;   (message "Initializing Grimoire")
;;   (kill-all-local-variables)
;;   (setq major-mode 'grimoire-mode)
;;   (setq mode-name "Grimoire")
;;   (run-hooks 'grimoire-mode-hook))


;; (defun grimoire-search-completion-dynamic (prefix)
;;   `("ax", "bx", "cx", "dx")
;;   )

;; (defun grimoire-search-completion (input predicate flag)
;;   `("ax", "bx", "cx", "dx")
;;   )

;; (defun grimoire-search-old-1 ()
;;   (interactive)
;;   (completing-read
;;    "Grimoire Search: "
;;    `grimoire-search-completion
;;    )
;;   )


;; (defun grimoire-search ()
;;   (interactive)
;;   (selectrum-completing-read
;;   ; (completing-read
;;    "Grimoire Search: "
;;    ; `selectrum-refine-candidates-function
;;    `(("a" 1) ("b" 2) ("c" 3))
;;    )
;;   )

;; (defun update-thing ()
;;   (switch-to-buffer grimoire-buffer)
;;   (insert "xxxxx")
;;   )


;; (defun grimoire-search-completion-selectrum (user-input current-list)
;;   ; (update-thing)
;;   `("ex", "fx", "gx", "hx")
;;   )

;; (setq selectrum-refine-candidates-function
;;       #'grimoire-search-complection-selectrumx)


;; (defun grimoire-search-function (prompt collection &optional
;;             predicate require-match initial-input
;;             hist def _inherit-input-method)
;;   (switch-to-buffer grimoire-buffer)
;;   (insert "HERE")
;;       )

; (setq completing-read-function 'grimoire-search-function)

;; (defun grimoire-output ()
;;   (switch-to-buffer grimoire-buffer)
;;   (insert (completing-read
;;            "Grimoire Search"
;;            '(
;;              ("a" 1)
;;              ("b" 2)
;;              ("c" 3)
;;              )
;;            )
;;           )
;;    )

;; (defun grimoire ()
;;   "Test to see if this provides grimoire"
;;   (interactive)
;;   (switch-to-buffer grimoire-buffer)
;;   (if (not (eq major-mode 'grimoire-mode))
;;       (grimoire-mode)
;;       )
;;   (grimoire-output)
;;   )


; (provide 'grimoire)


(defvar page-to-open 
  "The page to open when the search is done"
  )


(defvar meilisearch-auth-token nil 
  "The search key for meilisearch"
  )

(defvar curl-search-command nil
  "The curl command used to query meilisearch"
  )

(defun aws-open-file (line)
  (switch-to-buffer grimoire-buffer)
  (insert "here")
  (insert (car line))
  (insert (cdr line))
  )

(defun file-to-string (file)
  "Read a file into a string"
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)
    )
  )




; This is what makes the updates happen when chaging the selection
(setq helm-move-selection-after-hook 'aws-get-line)

(defun aws-get-line ()
  (switch-to-buffer grimoire-buffer)
  (insert "Moved selection to: ")
  (insert (helm-get-selection nil t))
  (insert "\n")
  )

(defun aws-helm-test()
  (setq meilisearch-auth-token
        (string-clean-whitespace
         (file-to-string "/Users/alan/configs/grimoire-mode/meilisearch-token")
        )
        )

  (interactive)
  (switch-to-buffer grimoire-buffer)
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


;; (defun x-aws-helm-test-original ()
;;     (interactive)
;;     (switch-to-buffer grimoire-buffer)
;;     (helm :sources (helm-build-async-source "aws-helm-source-original"
;;                      :candidates-process
;;                      (lambda ()
;;                        (switch-to-buffer grimoire-buffer)
;;                        (insert "Changed search to: ")
;;                        (insert helm-pattern)
;;                        (insert "\n")
;;                                         ; (insert helm-buffer)
;;                         ; (start-process "echo" nil "echo" (shell-quote-argument helm-pattern))))
;;                         (start-process "echo" nil "echo" "a\nb\nc\nd\ne")

                       ;; (start-process
                       ;;  "curl" nil "curl" "-s" "-X" "GET"
                       ;;  "http://127.0.0.1:7575/indexes/set-1/search?q=fox"
                       ;;  "-H"
                       ;;  "Authorization: Bearer $(security find-generic-password -w -a alan -s alan--meilisearch--scratchpad--search-key)"
                       ;;  "|" "jq" "-r" ".hits[] | .path"
                       ;;  )

                      ;)
      ; :buffer "*helm async source*"
      ; :get-line 'aws-get-line
      ; :persistent-action 'aws-get-line
      ; :action '(("Open file" . aws-open-file))
      ; :get-line 'buffer-substring

;;       )
;;       )
;;     (insert "Page to open: ")
;;     (insert page-to-open)
;;     (insert "\n")
;; )


; (insert candidate)

;; (defun aws-helm-test ()
;;   (interactive)
;;   (helm :sources 'aws-helm-source
;;         :buffer "*helm my command*"))


