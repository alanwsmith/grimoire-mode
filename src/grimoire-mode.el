(require 'helm)
(require 'helm-lib)
(require 'helm-utils)


(defun grimoire-mode-search-v0.10 ()
  (interactive)
  (helm :sources
        (helm-build-async-source "Grimoire Search"
          :candidates-process
          (lambda ()
            (if (string= helm-pattern "")
                (start-process "bash"
                               nil
                               "/bin/bash"
                               "-c"
                               "echo 'Ready...'")
              (start-process "search" nil "/bin/bash" "/Users/alan/workshop/grimoire-mode/src/search-process" helm-pattern)
              )
            )
          )
        :buffer "*helm grimoire search*"
        )
  )


(global-set-key [f5] 'grimoire-mode-search-v0.10)
