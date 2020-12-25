(setq user-full-name "Zulfiqar Soomro"
      user-mail-address "me@zusoomro.com")

(setq doom-font (font-spec :family "Fira Code" :size 13)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 13))

(setq doom-theme 'doom-one-light)

(setq display-line-numbers-type nil)

;; here are some additional functions/macros that could help you configure doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; to get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'k' (non-evil users must press 'c-c c k').
;; this will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq visual-fill-column-center-text t)
(setq-default line-spacing 4)

(setq kill-whole-line t)

(after! org
  (map! :map org-mode-map :g "C-'" 'nil)
  (map! :g "C-'" 'avy-goto-char)
  )
(avy-setup-default)

(setq swiper-use-visual-line-p #'ignore)

;;(map! :g "C-s" #'swiper-isearch)
;;(map! :g "C-r" #'swiper-isearch-backward)

;; if you use `org' and don't want your org files in the default location below,
;; change `org-directory'. it must be set before org loads!

(setq root-directory "~/Dropbox")
(setq gtd-directory (concat root-directory "/gtd"))
(setq notes-directory (concat root-directory "/notes"))
(setq journal-directory (concat root-directory "/journal"))

(setq org-directory notes-directory)
(setq org-roam-directory notes-directory)
(setq org-agenda-files `("~/Dropbox/gtd"))
(setq org-journal-dir journal-directory)
(setq org-archive-location (concat gtd-directory "/archive.org_archive::datetree/"))

(add-hook! org-mode (visual-fill-column-mode))
(setq org-startup-folded t)
(setq org-hide-emphasis-markers t)
;; (setq mixed-pitch-set-height t)
;; (add-hook! org-mode (mixed-pitch-mode))

(setq org-pomodoro-keep-killed-time t)
(setq org-pomodoro-keep-killed-pomodoro-time t)

;; (after! (pdf-tools org-noter)
;;   (map! :map pdf-view-mode-map
;;         :n "i" #'org-noter-insert-note))

(setq org-agenda-dim-blocked-tasks nil)
(setq org-agenda-custom-commands
      '(("c" "cis380" tags-todo "cis380")
        ("C" "cis400" tags-todo "cis400")
        ("u" "urbs420" tags-todo "urbs420")
        ("e" "econ045" tags-todo "econ045")
        ("l" "lgst206" tags-todo "lgst206")
        ("i" "inbox" tags-todo "inbox")
        ("p" "projects" tags-todo "projects")
        ("h" "habits" tags-todo "STYlE=\"habit\"")
        ("n" "next-actions" todo "STRT")
        ("r" "routines" search "Routine")
        ("o" "Daily Agenda"
         ((agenda "" (
                      (org-agenda-span 1)
                      (org-agenda-overriding-header "Agenda")
                      (org-agenda-start-day ".")
                      ))
          (todo "STRT" ((org-agenda-overriding-header "Next actions"))))
         ((org-agenda-block-separator nil)
          (org-habit-show-habits nil))
         )
        ))

(setq org-tag-persistent-alist '(
                                 (:startgroup . nil)
                                 ("cis380" . ?c)
                                 ("cis400" . ?C)
                                 ("urbs420" . ?u)
                                 ("econ045" . ?e)
                                 ("lgst206" . ?l)
                                 (:newline . nil)
                                 ("work" . ?w)
                                 ("personal" . ?p)
                                 ("school" . ?s)
                                 ("social" . ?S)
                                 ("TA" . ?t)
                                 ("vehicle" . ?v)
                                 ))

(map! [remap org-set-tags-command] nil)

(after! org (setq org-capture-templates
                  `(("i" "Inbox" entry (file "~/Dropbox/gtd/inbox.org")
                     ,(concat "* TODO %?\n"
                              "/Entered on/ %U"))
                    ("I" "Inbox w/ attachment" entry (file "~/Dropbox/gtd/inbox.org")
                     ,(concat "* TODO %?\n"
                              "%a\n"
                              "/Entered on/ %U"))
                    )))

(setq org-journal-file-format "%Y-%m-%d.org")

(require 'org-checklist)
(after! org (add-to-list 'org-modules 'org-habit t)
  (add-to-list 'org-modules 'org-checklist t))

(after! org-caldav
  (setq
   org-caldav-url "https://caldav.fastmail.com/dav/calendars/user/me@zusoomro.com/"
   org-caldav-calendar-id "54b62cc0-e024-4081-a88a-14abdf81d875"
   org-caldav-inbox "~/Dropbox/gtd/calendar-two.org"
   org-caldav-backup-file "~/Dropbox/gtd/calendar.org.bak"
   ))

(setq +org-roam-open-buffer-on-find-file nil)

(setq org-export-preserve-breaks t)

(after! mu4e
  ;; Each path is relative to `+mu4e-mu4e-mail-path', which is ~/.mail by default
  (setq mu4e-view-prefer-html t)
  (setq fill-flowed-encode-column 998)
  (setq mu4e-maildir-shortcuts '(
                                 (:maildir "/me/Spam" :key ?S)
                                 (:maildir "/seas/[Gmail]/Spam" :key ?s)
                                 (:maildir "/me/INBOX" :key ?I)
                                 (:maildir "/seas/INBOX" :key ?i)))
  (setq +mu4e-mu4e-mail-path "~/.mail")

  (set-email-account! "me"
                      '((mu4e-sent-folder       . "/me/Sent")
                        (mu4e-drafts-folder     . "/me/Drafts")
                        (mu4e-trash-folder      . "/me/Trash")
                        (mu4e-refile-folder     . "/me/Archive")
                        (smtpmail-smtp-user     . "me@zusoomro.com")
                        (user-mail-address      . "me@zusoomro.com")
                        (smtpmail-default-smtp-server . "smtp.fastmail.com")
                        (smtpmail-smtp-server         . "smtp.fastmail.com")
                        (smtpmail-stream-type . starttls)
                        (smtpmail-smtp-service . 587))
                      t)

  (set-email-account! "gmail"
                      '((mu4e-sent-folder       . "/gmail/[Gmail]/Sent Mail")
                        (mu4e-drafts-folder     . "/gmail/[Gmail]/Drafts")
                        (mu4e-trash-folder      . "/gmail/[Gmail]/Trash")
                        (mu4e-refile-folder     . "/gmail/[Gmail]/All Mail")
                        (smtpmail-smtp-user     . "zulfiqar0821@gmail.com")
                        (user-mail-address      . "zulfiqar0821@gmail.com")
                        (smtpmail-default-smtp-server . "smtp.gmail.com")
                        (smtpmail-smtp-server         . "smtp.gmail.com")
                        (smtpmail-smtp-server         . "smtp.gmail.com")
                        (smtpmail-stream-type . ssl)
                        (smtpmail-smtp-service . 465))
                      t)

  (set-email-account! "seas"
                      '((mu4e-sent-folder       . "/seas/[Gmail]/Sent Mail")
                        (mu4e-drafts-folder     . "/seas/[Gmail]/Drafts")
                        (mu4e-trash-folder      . "/seas/[Gmail]/Trash")
                        (mu4e-refile-folder     . "/seas/[Gmail]/All Mail")
                        (smtpmail-smtp-user     . "zusoomro@seas.upenn.edu")
                        (user-mail-address      . "zusoomro@seas.upenn.edu")
                        (smtpmail-default-smtp-server . "smtp.gmail.com")
                        (smtpmail-smtp-server         . "smtp.gmail.com")
                        (smtpmail-smtp-server         . "smtp.gmail.com")
                        (smtpmail-stream-type . ssl)
                        (smtpmail-smtp-service . 465))
                      t)
  (setq
   message-send-mail-function   'smtpmail-send-it
   send-mail-function   'smtpmail-send-it
   smtpmail-default-smtp-server "smtp.fastmail.com"
   smtpmail-smtp-server         "smtp.fastmail.com"
   smtpmail-stream-type 'starttls
   smtpmail-smtp-service 587)

  (add-to-list 'mu4e-bookmarks '("maildir:\"/me/INBOX\" OR  maildir:\"/seas/INBOX\" OR  maildir:\"/gmail/INBOX\"" "Inboxes" ?i))
  )

;; (add-hook! mu4e-view-mode
;;   (visual-fill-column-mode)
;;   (auto-fill-mode -1)
;;   )
(setq-hook! 'mu4e-view-mode visual-fill-column-center-text nil)

(map! :map mu4e-headers-mode-map :n "/" `evil-ex-search-forward)

;; config.el
(use-package slack
  :commands slack-start
  :init
  (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)
  :config
  (slack-register-team
   :name "Senior Design"
   :token (auth-source-pick-first-password
           :host "seniordesign-hma6210.slack.com"
           :user "me@zusoomro.com")
   :subscribed-channels '((general random)))

  (slack-register-team
   :name "CIS557"
   :token (auth-source-pick-first-password
           :host "cis-557.slack.com"
           :user "zusoomro@seas.upenn.edu")
   :subscribed-channels '((general random)))

  ;; (map! (:map slack-info-mode-map
  ;;        "u" #'slack-room-update-messages)
  ;;       (:map slack-mode-map
  ;;        "C-n" 'slack-buffer-goto-next-message
  ;;        "C-p" 'slack-buffer-goto-prev-message)
  ;;       (:localleader
  ;;        (:map slack-mode-map
  ;;         "c" 'slack-buffer-kill
  ;;         "ra" 'slack-message-add-reaction
  ;;         "rr" 'slack-message-remove-reaction
  ;;         "rs" 'slack-message-show-reaction-users
  ;;         "pl" 'slack-room-pins-list
  ;;         "pa" 'slack-message-pins-add
  ;;         "pr" 'slack-message-pins-remove
  ;;         "mm" 'slack-message-write-another-buffer
  ;;         "me" 'slack-message-editp
  ;;         "md" 'slack-message-delete
  ;;         "u" 'slack-room-update-messages
  ;;         "2" 'slack-message-embed-mention
  ;;         "3" 'slack-message-embed-channel)
  ;;        (:map slack-edit-message-mode-map
  ;;         "k" 'slack-message-cancel-edit
  ;;         "s" 'slack-message-send-from-buffer
  ;;         "2" 'slack-message-embed-mention
  ;;         "3" 'slack-message-embed-channel))))
  )
(use-package alert
  :commands alert
  :init (setq alert-default-style 'notifier))

(map! :map dired-mode-map :g "-" `dired-up-directory)

(after! java-mode (setq c-basic-offset 4))
(setq js-indent-level 2)
(setq typescript-indent-level 2)
(setq web-mode-code-indent-offset 2
      web-mode-markup-indent-offset 2)
(after! lsp-mode (setq +format-with-lsp nil))
(setq +format-with-lsp nil)
(setq-hook! 'typescript-tsx-mode +format-with-lsp nil)
(setq-hook! 'typescript-mode +format-with-lsp nil)
(setq +default-want-RET-continue-comments nil)

(defun zulfi/hello-world ()
  "My first elisp function!"
  (interactive)
  (message "Hello World!"))

(defun zulfi/magit-refresh-maybe ()
  (dolist (buf (doom-buffers-in-mode 'magit-status-mode))
    (with-current-buffer buf
      (magit-refresh-buffer))))
(run-with-idle-timer 3 t #'zulfi/magit-refresh-maybe)

(defun zulfi/senior-design-terminals ()
  "Opens the terminals for senior design"
  (interactive)
  ;; Open and set up the api terminal
  (call-interactively `doom/window-maximize-buffer)
  (call-interactively `+vterm/here)
  (end-of-buffer)
  (vterm-send-string "cd ~/code/wigo/api\n")
  (vterm-send-string "source .env\n")
  (vterm-send-string "yarn start\n")

  ;; Split and move terminals
  (call-interactively `split-window-right)

  ;; Set up the mobile terminal
  (call-interactively `+vterm/here)
  (end-of-buffer)
  (vterm-send-string "cd ~/code/wigo/mobile\n")
  (vterm-send-string "yarn start\n")

  ;; Save the window configuration and return
  (window-configuration-to-register ?a)
  (message "Done!")
  )
(map! :leader
      :desc "Open senior design terminals"  :g "o C"
      'zulfi/senior-design-terminals)

(defun zulfi/penn-os-terminals ()
  "Opens the terminals for penn-os"
  (interactive)
  ;; Open and set up the api terminal
  (call-interactively `doom/window-maximize-buffer)
  (call-interactively `+vterm/here)
  (end-of-buffer)
  (vterm-send-string "cd ~/code/cis380/20fa-project-2-group-14\n")
  (vterm-send-string "vagrant up\n")
  (vterm-send-string "vagrant ssh\n")
  (vterm-send-string "cd /vagrant/20fa-project-2-group-14\n")

  ;; Save the window configuration and return
  (window-configuration-to-register ?a)
  (message "Done!")
  )
;; (map! :leader
;;       :desc "Open penn-os terminals"  :m "o c" 'penn-os-terminals)

(defvar zulfi/org-habit-show-graphs-everywhere t
  "If non-nil, show habit graphs in all types of agenda buffers.

Normally, habits display consistency graphs only in
\"agenda\"-type agenda buffers, not in other types of agenda
buffers.  Set this variable to any non-nil variable to show
consistency graphs in all Org mode agendas.")

(defun zulfi/org-agenda-mark-habits ()
  "Mark all habits in current agenda for graph display.

This function enforces `zulfi/org-habit-show-graphs-everywhere' by
marking all habits in the current agenda as such.  When run just
before `org-agenda-finalize' (such as by advice; unfortunately,
`org-agenda-finalize-hook' is run too late), this has the effect
of displaying consistency graphs for these habits.

When `zulfi/org-habit-show-graphs-everywhere' is nil, this function
has no effect."
  (when (and zulfi/org-habit-show-graphs-everywhere
             (not (get-text-property (point) 'org-series)))
    (let ((cursor (point))
          item data)
      (while (setq cursor (next-single-property-change cursor 'org-marker))
        (setq item (get-text-property cursor 'org-marker))
        (when (and item (org-is-habit-p item))
          (with-current-buffer (marker-buffer item)
            (setq data (org-habit-parse-todo item)))
          (put-text-property cursor
                             (next-single-property-change cursor 'org-marker)
                             'org-habit-p data))))))

(advice-add #'org-agenda-finalize :before #'zulfi/org-agenda-mark-habits)

(defun zulfi/set-system-dark-mode ()
  (interactive)
  (if (string= (shell-command-to-string "printf %s \"$( osascript -e \'tell application \"System Events\" to tell appearance preferences to return dark mode\' )\"") "true")
      (when (string= doom-theme "doom-one-light") (load-theme 'doom-one t))
    (when (string= doom-theme "doom-one") (load-theme 'doom-one-light t))
    )
  )

(run-with-idle-timer 3 t #'zulfi/set-system-dark-mode)

(add-hook! nov-mode
  (setq visual-fill-column-mode t)
  (setq visual-fill-column-center-text t)
  (setq line-spacing 4))

(add-hook! writeroom-mode (doom/reset-font-size))

(after! fill-column (setq visual-fill-column-center-text t))



;; (setq evil-vsplit-window-right t
;;       evil-split-window-below t)

(setq delete-by-moving-to-trash t)
