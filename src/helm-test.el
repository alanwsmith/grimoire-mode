; This is just a test to verify the way the helm
; window opens. With just this, it opens properly
; which means something weird is going on in the
; current v0.6 - v0.8 version of the grimoire

(require 'helm)
(require 'helm-lib)
(require 'helm-utils)


(defun grimoire-mode-search-v0.9 ()
  (interactive)
  (helm :sources (helm-build-sync-source "test"
                   :candidates '(a b c d e))
        :buffer "*helm sync source*")
  )

; (global-set-key [f5] 'grimoire-mode-search-v0.9)
; (global-set-key [f6] 'helm-info)

