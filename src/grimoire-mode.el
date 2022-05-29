(require 'helm)
(require 'helm-lib)
(require 'helm-utils)

;; See .spacemacs for setting grimoire-mode-directory

(defconst grimoire-mode-buffer "*Grimoire*"
  "Name of the Grimoire buffer")

(defvar grimoire-mode-helm-buffer-line 0
  "Storage for the current line position of
the helm buffer")

(defvar grimoire-mode-helm-buffer-line-adjusted 0
  "Adjusted to accont for the fact the results
start on the second line")

(defvar grimoire-mode-get-search-content-script
  "/Users/alan/workshop/grimoire-mode/src/get-search-content"
  "Path to the script that returns the content to populate
the grimoire preview"
  )

(defvar grimoire-mode-get-search-results-script
  "/Users/alan/workshop/grimoire-mode/src/get-search-results"
  "Path to the script that returns the content to populate the
results in the grimoire"
  )

(defun grimiore-mode-test (candidate)

  (switch-to-buffer grimoire-mode-buffer)

  ;; (message (number-to-string helm-follow-input-idle-delay))
  ;; (message (number-to-string tooltip-delay))
  ;; (message (number-to-string idle-update-delay))
  ;; (message (number-to-string helm-input-idle-delay))
  ;; (message (number-to-string helm-idle-delay))
  ;; (message (number-to-string helm-cycle-result-delay))

  (if (string= candidate "Ready...")
      (message "No file selected.")
    (find-file(concat grimoire-mode-directory "/" candidate))
  )

  )

(defun grimoire-mode-handle-selection (return-value)

  ;; ;; (message return-value)
  ;; (if (string= return-value nil)
  ;;     (message "No file selected.")
  ;; (if (string= return-value "Ready...")
  ;;     (message "No file selected.")
  ;;   (progn
  ;;     (message (concat "Loading: " return-value) )
  ;;     (find-file(concat grimoire-mode-directory "/" return-value))
  ;;     (org-mode)
  ;;     )))


  )

(defun grimoire-mode-update-preview ()

  ;; (setq grimoire-mode-helm-buffer-line
  ;;       (with-current-buffer helm-buffer (string-to-number (format-mode-line "%l"))))
  ;; (setq grimoire-mode-helm-buffer-line-adjusted
  ;;       (max (- grimoire-mode-helm-buffer-line 2) 0) )
  ;; ;; (message (number-to-string grimoire-mode-helm-buffer-line))
  ;; (switch-to-buffer grimoire-mode-buffer)
  ;; (erase-buffer)
  ;; (if (string= helm-pattern "")
  ;;     (message "No file selected")
  ;;   (call-process
  ;;  "/bin/bash"
  ;;  nil
  ;;  grimoire-mode-buffer
  ;;  nil
  ;;  grimoire-mode-get-search-content-script
  ;;  helm-pattern
  ;;  (number-to-string grimoire-mode-helm-buffer-line-adjusted)))
  ;; (goto-char (point-min))


  )


;; TODO: Figure out if you need to set this:
;; (setq helm-follow-input-idle-delay 0.5)
;; Looks like it's null to start. 

;; TODO: See about adding :cleanup for
;; closing things down

;; TODO: Look at :nohighlight

;; NOTE: note sure if :follow-delay is having
;; any effect. 


(defun grimoire-mode-search-v0.10 ()
  (interactive)
  ; (setq helm-move-selection-after-hook 'grimoire-mode-update-preview)
  (switch-to-buffer grimoire-mode-buffer)

  (org-mode)
  (grimoire-mode-handle-selection(helm :sources
        (helm-build-async-source "Grimoire Search"
          :follow 1
          :follow-delay 0.001
          :persistent-action 'grimiore-mode-test 
          :candidates-process
          (lambda ()
            (grimoire-mode-update-preview)
            (start-process
             "search"
             nil
             "/bin/bash"
             grimoire-mode-get-search-results-script
             helm-pattern)))
        :buffer "*helm grimoire search*"))
  ; (setq helm-move-selection-after-hook nil)
  (kill-buffer grimoire-mode-buffer))

