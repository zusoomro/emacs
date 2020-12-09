;; place your private configuration here! remember, you do not need to run 'doom
;; sync' after modifying this file!

;; some functionality uses this to identify you, e.g. gpg configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Zulfiqar Soomro"
      user-mail-address "me@zusoomro.com")

;; doom exposes five (optional) variables for controlling fonts in doom. here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; they all accept either a font-spec, font string ("input mono-12"), or xlfd
;; font string. you generally only need these two:
(setq doom-font (font-spec :family "JetBrains Mono" :size 13)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 13))

;; there are two ways to load a theme. both assume the theme is installed and
;; available. you can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. this is the default:
(setq doom-theme 'doom-one)

;; some favorite themes:
;; - doom-one-light
;; - doom-city-lights
;; - doom-henna
;; - doom-oceanic-next


;; this determines the style of line numbers in effect. if set to `nil', line
;; numbers are disabled. for relative line numbers, set this to `relative'.
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

(setq js-indent-level 2)
(setq typescript-indent-level 2)
(setq web-mode-code-indent-offset 2
      web-mode-markup-indent-offset 2)

(after! java-mode (setq c-basic-offset 4))

(add-hook! nov-mode
  (setq visual-fill-column-mode t)
  (setq visual-fill-column-center-text t)
  (setq line-spacing 4))

(add-hook! writeroom-mode (doom/reset-font-size))

(after! fill-column (setq visual-fill-column-center-text t))



(setq evil-vsplit-window-right t
      evil-split-window-below t)

(setq delete-by-moving-to-trash t)

(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)

(setq mac-right-option-modifier 'meta)
(setq mac-right-command-modifier 'meta)

(setq swiper-use-visual-line-p #'ignore)

(map! :g "C-s" #'swiper-isearch)
(map! :g "C-r" #'swiper-isearch-backward)

(setq visual-fill-column-center-text t)
(setq-default line-spacing 4)
;; (add-hook! 'window-setup-hook 'toggle-frame-fullscreen)

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

(after! org (add-to-list 'org-modules 'org-habit t))

(after! org-caldav
  (setq
   org-caldav-url "https://caldav.fastmail.com/dav/calendars/user/me@zusoomro.com/"
   org-caldav-calendar-id "54b62cc0-e024-4081-a88a-14abdf81d875"
   org-caldav-inbox (concat gtd-directory "/calendar.org")
   org-caldav-backup-file nil
   ))

(setq +org-roam-open-buffer-on-find-file nil)

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
  (add-to-list 'mu4e-bookmarks '("maildir:\"/me/INBOX\" OR maildir:\"/seas/INBOX\"" "Inboxes" ?i))
  )

;; (add-hook! mu4e-view-mode
;;   (visual-fill-column-mode)
;;   (auto-fill-mode -1)
;;   )
(setq-hook! 'mu4e-view-mode visual-fill-column-center-text nil)

(map! :map mu4e-headers-mode-map :n "/" `evil-ex-search-forward)

(setq +workspaces-switch-project-function (lambda (_) (projectile-dired)))

(defun hello-world ()
  "My first elisp function!"
  (interactive)
  (message "Hello World!"))

(defun magit-refresh-maybe ()
  (dolist (buf (doom-buffers-in-mode 'magit-status-mode))
    (with-current-buffer buf
      (magit-refresh-buffer))))
(run-with-idle-timer 3 t #'magit-refresh-maybe)

(defun senior-design-terminals ()
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
  (call-interactively `evil-window-vsplit)
  (evil-force-normal-state)

  ;; Set up the mobile terminal
  (call-interactively `+vterm/here)
  (end-of-buffer)
  (vterm-send-string "cd ~/code/wigo/mobile\n")
  (vterm-send-string "yarn start\n")
  (evil-force-normal-state)

  ;; Save the window configuration and return
  (window-configuration-to-register ?a)
  (message "Done!")
  )
(map! :leader
      :desc "Open senior design terminals"  :m "o C" 'senior-design-terminals)

(defun penn-os-terminals ()
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

(defvar my/org-habit-show-graphs-everywhere t
  "If non-nil, show habit graphs in all types of agenda buffers.

Normally, habits display consistency graphs only in
\"agenda\"-type agenda buffers, not in other types of agenda
buffers.  Set this variable to any non-nil variable to show
consistency graphs in all Org mode agendas.")

(defun my/org-agenda-mark-habits ()
  "Mark all habits in current agenda for graph display.

This function enforces `my/org-habit-show-graphs-everywhere' by
marking all habits in the current agenda as such.  When run just
before `org-agenda-finalize' (such as by advice; unfortunately,
`org-agenda-finalize-hook' is run too late), this has the effect
of displaying consistency graphs for these habits.

When `my/org-habit-show-graphs-everywhere' is nil, this function
has no effect."
  (when (and my/org-habit-show-graphs-everywhere
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

(advice-add #'org-agenda-finalize :before #'my/org-agenda-mark-habits)
