(require 'helm)
(require 'helm-lib)
(require 'helm-utils)

;; NOTE: I think this needs to be set in the custom
;; config section of the spacemacs config:
;; '(idle-update-delay 0.1)

;; See .spacemacs for setting grimoire-mode-directory
;; and grimoire-mode-get-search-results-script

(defconst grimoire-mode-buffer "*Grimoire*"
  "Name of the Grimoire buffer")

;; TODO: Figure out where to put this
(defvar grimoire-history-file "/Users/alan/Desktop/grimoire-history.txt")

(defun grimoire-mode-handle-selection (selection)
  (unless (string= selection nil)
    (unless (string= selection "Ready...")
      (progn
        (setq grimoire-file-name selection)
        (if (string=
             (subseq selection (- (length selection) 1))
             ".")
            (progn
              (setq grimoire-file-name (concat selection "org"))
              (make-empty-file (concat grimoire-mode-directory "/" grimoire-file-name))
              )
          )
        (with-temp-file grimoire-history-file
          (insert grimoire-file-name)
          (insert "\n")
          ;; TODO: Make the file if it doesn't exist. 
          (if (file-exists-p grimoire-history-file)
              (insert-file-contents grimoire-history-file)))
        (find-file(concat grimoire-mode-directory "/" grimoire-file-name))
        (org-mode)
        )
      )
    )
  )

(defun grimiore-mode-handle-preview (candidate)
  (if (string= candidate "Ready...")
      (progn
        (switch-to-buffer grimoire-mode-buffer)
        (erase-buffer)
        )
    (progn
      (switch-to-buffer grimoire-mode-buffer)
      (erase-buffer)
      (find-file(concat grimoire-mode-directory "/" candidate))
      (insert-into-buffer grimoire-mode-buffer)
      (unless (buffer-modified-p)
        (kill-buffer (current-buffer))
        )
      (goto-char (point-min))
      (org-mode)
    )
    )
  )

(defun grimoire-mode-search ()
  (interactive)
  (setq grimoireFrame nil)
  (dolist (frame (frame-list))
    (if (frame-parameter frame 'grimoirex) 
        (setq grimoireFrame frame)))
  (if (not grimoireFrame)
      ((lambda() 
         (make-frame)
         (set-frame-parameter nil 'grimoirex t)))
    (select-frame-set-input-focus grimoireFrame))

  (grimoire-mode-handle-selection(helm :sources
        (helm-build-async-source "Grimoire Search"
          :follow 1
          :follow-delay 0.001
          :persistent-action 'grimiore-mode-handle-preview
          :candidates-process
          (lambda ()
            (start-process
             "search"
             nil
             "/opt/homebrew/bin/python3"
             grimoire-mode-get-search-results-script
             helm-pattern)))
        :buffer "*helm grimoire search*"))
  (kill-buffer grimoire-mode-buffer))

