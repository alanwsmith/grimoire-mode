(require 'helm)
(require 'helm-lib)
(require 'helm-utils)

(defconst grimoire-mode-buffer "*Grimoire*"
  "Name of the Grimoire buffer")

(defun grimiore-mode-update-preview ()
  (switch-to-buffer grimoire-mode-buffer)
  (insert "asdf")
  (erase-buffer)
  (call-process "/bin/bash" nil grimoire-mode-buffer nil "get-search-content" helm-pattern)
  (goto-char (point-min))
  )

(defun grimoire-mode-search-v0.10 ()
  (interactive)
  (switch-to-buffer grimoire-mode-buffer)
  (helm :sources
        (helm-build-async-source "Grimoire Search"
          :candidates-process
          (lambda ()
            (grimiore-mode-update-preview)
            (start-process "search" nil "/bin/bash" "/Users/alan/workshop/grimoire-mode/src/search-process" helm-pattern)
            )
          )
        :buffer "*helm grimoire search*"
        )
  (kill-buffer grimoire-mode-buffer)
  )

; This is an effort to reduce flickering
(setq helm-input-idle-delay 0.01)

(global-set-key [f5] 'grimoire-mode-search-v0.10)
