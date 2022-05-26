(defun run-v3 ()
  '(a b c d e f)
       )

(defun grimoire-mode-search-v3 ()
  "This is a test to see about using the main sync-source
but that won't work becuase it's the content that needs to
be searched which means the content needs to be handled
externally"

  (interactive)
  (switch-to-buffer "*Grimoire*")
  (helm :sources (helm-build-sync-source "helm-grimoire-mode-search-v3"
        :candidates (lambda ()
                      (run-v3)
                      ; '("a" "b" "c")
                      )
  )
        :buffer "*helm buffer*"
)
)


