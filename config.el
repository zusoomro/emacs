(setq user-full-name "Zulfiqar Soomro"
      user-mail-address "me@zusoomro.com")

(setq doom-font (font-spec :family "JetBrains Mono" :size 13)
      doom-variable-pitch-font (font-spec :family "Charter" :size 15))

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

(after! org
  (map! :map org-mode-map :g "C-'" 'nil)
  (map! :g "C-'" 'avy-goto-char)
  )

(unless (featurep! :editor evil) (avy-setup-default))

(setq swiper-use-visual-line-p #'ignore)

(map! :g "C-s" #'swiper-isearch)
(map! :g "C-r" #'swiper-isearch-backward)

(setq mac-right-option-modifier 'meta)
(setq mac-command-modifier 'super)
(setq mac-right-command-modifier 'left)

(setq epa-file-cache-passphrase-for-symmetric-encryption t)

;; if you use `org' and don't want your org files in the default location below,
;; change `org-directory'. it must be set before org loads!

(setq root-directory "~/cloud")
(setq gtd-directory (concat root-directory "/notes"))
(setq notes-directory (concat root-directory "/notes"))
(setq journal-directory (concat root-directory "/journal"))

(setq org-directory notes-directory)
(setq org-roam-directory notes-directory)
(setq org-agenda-files `("~/cloud/gtd/inbox.org"
                         "~/cloud/gtd/projects.org"
                         "~/cloud/gtd/agenda.org") )
(setq org-journal-dir journal-directory)
(setq org-archive-location (concat gtd-directory "/archive.org_archive::datetree/"))

;; (add-hook! org-mode (visual-fill-column-mode))
(setq org-startup-folded t)
(setq org-hide-emphasis-markers t)
(setq mixed-pitch-set-height t)
;; (add-hook! org-mode (mixed-pitch-mode))

(setq org-pomodoro-keep-killed-time t)
(setq org-pomodoro-keep-killed-pomodoro-time t)

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
        ("n" "next-actions" tags-todo "next")
        ("r" "routines" search "Routine")
        ("o" "Daily Agenda"
         ((agenda "" (
                      (org-agenda-span 1)
                      (org-agenda-overriding-header "Agenda")
                      (org-agenda-start-day ".")
                      ))
          (tags-todo "next" ((org-agenda-overriding-header "Next actions")))
          (todo "WAIT" ((org-agenda-overriding-header "Waiting")))
          ;; (tags-todo "STYlE=\"habit\"" ((org-agenda-overriding-header "Habits")))
          )
         ;; (
         ;;  (org-habit-show-habits nil))
         )
        ))
(setq org-stuck-projects '("+LEVEL=2/-DONE/-SMDY/-TAG" ("NEXT" "NEXTACTION") ("someday" "agenda") ""))

(setq org-agenda-include-diary t)

(setq org-tag-persistent-alist '(
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
                                 ("next" . ?n)
                                 ("businesshours" . ?b)
                                 ))

;; (map! [remap org-set-tags-command] 'counsel-org-tag)

(after! org (setq org-capture-templates
                  `(("i" "Inbox" entry (file "~/cloud/gtd/inbox.org")
                     ,(concat "* TODO %?\n"
                              "/Entered on/ %U"))
                    ("I" "Inbox w/ attachment" entry (file "~/cloud/gtd/inbox.org")
                     ,(concat "* TODO %?\n"
                              "%a\n"
                              "/Entered on/ %U"))
                    )))

(setq org-journal-file-format "%Y-%m-%d.org"
      org-journal-file-type 'weekly)

(require 'org-checklist)
(after! org (add-to-list 'org-modules 'org-habit)
  (add-to-list 'org-modules 'org-checklist))

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "PROJ(p)" "WAIT(w)" "|" "DONE(d)" "CNCL(c)" "SMDY(s)"))

      org-todo-keyword-faces
      '(("[-]" . +org-todo-active)
        ("NEXT" . +org-todo-active)
        ("[?]" . +org-todo-onhold)
        ("WAIT" . +org-todo-onhold)
        ("HOLD" . +org-todo-onhold)
        ("SMDY" . +org-todo-onhold)
        ("PROJ" . +org-todo-project))
      )

(add-to-list `org-refile-targets '("~/cloud/notes/20210117163945-reading_list.org" :maxlevel . 1))
(add-to-list `org-refile-targets '("~/cloud/notes/20210120095250-grocery_list.org" :maxlevel . 1))
(add-to-list `org-refile-targets '("~/cloud/notes/20210120095223-pharmacy_list.org" :maxlevel . 1))
(add-to-list `org-refile-targets '("~/cloud/notes/20210120123715-things_to_think_about.org" :maxlevel . 1))
(add-to-list `org-refile-targets '("~/cloud/gtd/someday.org" :maxlevel . 1))

(add-hook! org-mode (auto-fill-mode))

(defhydra process-inbox nil
  "zoom"
  ("n" zulfi/mark-as-next-action "next")
  ("d" org-cut-subtree "delete")
  ("j" org-next-visible-heading "down")
  ("k" org-previous-visible-heading "up")
  ("s" zulfi/mark-as-someday "someday")
  ("S" org-schedule "schedule")
  ("D" org-deadline "deadline")
  )

(map! :map dired-mode-map :g "-" `dired-up-directory)

(setq elfeed-feeds
      '(
        "http://feeds.bbci.co.uk/news/world/rss.xml"
        "https://hnrss.org/frontpage"
        "https://hnrss.org/bestcomments"
        ))

(setq projectile-project-search-path '("~/code"))
(after! java-mode (setq c-basic-offset 4))
(setq js-indent-level 2)
(setq typescript-indent-level 2)
(setq web-mode-code-indent-offset 2
      web-mode-markup-indent-offset 2)
(after! lsp-mode (setq +format-with-lsp nil))
(setq +format-with-lsp nil)
(setq-hook! typescript-tsx-mode +format-with-lsp nil)
(setq-hook! typescript-mode +format-with-lsp nil)
(setq +default-want-RET-continue-comments nil)
;; (add-hook! typescript-mode (sgml-mode))
;; (add-hook! typescript-tsx-mode (sgml-mode))
(after! tramp)

(after! mu4e
  ;; Each path is relative to `+mu4e-mu4e-mail-path', which is ~/.mail by default
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

(defun zulfi/generate-banner-string ()
  `(
    "Zulfi's Emacs."
    ,(format
      "There are %d days until the end of winter break."
      (org-time-stamp-to-now "<2021-01-20 Wed>")
      )
    )
  )

(defun zulfi/date-countdown ()
  (let* ((banner
          (zulfi/generate-banner-string))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn 'zulfi/date-countdown)

(defun zulfi/mark-as-next-action ()
  (interactive)
  (org-set-tags ":next:")
  (org-refile nil nil (list nil "~/cloud/gtd/projects.org" nil nil)))

(defun zulfi/mark-as-someday ()
  (interactive)
  (org-refile nil nil (list nil "~/cloud/gtd/someday.org" nil nil)))

(defun process-inbox ()
  (interactive)
  (find-file "~/cloud/gtd/inbox.org")
  (goto-char (point-min))
  (org-next-visible-heading 1)
  (process-inbox/body))

(map! :leader
      :desc "Open senior design terminals"  :g "o i"
      'process-inbox)

(after! fill-column (setq visual-fill-column-center-text t))
(setq delete-by-moving-to-trash t)
;; (setq evil-vsplit-window-right t
;;       evil-split-window-below t)
