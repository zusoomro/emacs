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
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 15))

;; there are two ways to load a theme. both assume the theme is installed and
;; available. you can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. this is the default:
(setq doom-theme 'doom-one-light)

;; some favorite themes:
;; - doom-one-light
;; - doom-city-lights
;; - doom-henna
;; - doom-oceanic-next

;; if you use `org' and don't want your org files in the default location below,
;; change `org-directory'. it must be set before org loads!
(setq org-directory "~/dropbox/notes")

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

(setq org-roam-directory "~/Dropbox/notes")
(setq visual-fill-column-center-text t)

(add-hook! org-mode (visual-fill-column-mode))

(setq org-agenda-files `("~/Dropbox/gtd/agenda.org" "~/Dropbox/gtd/projects.org" "~/Dropbox/inbox.org"))

(after! org (setq org-capture-templates
                  `(("i" "Inbox" entry  (file "~/Dropbox/gtd/inbox.org")
                     ,(concat "* TODO %?\n"
                              "/Entered on/ %U")))))


;; (setq mixed-pitch-set-height t)
;; (add-hook! org-mode (mixed-pitch-mode))

(setq org-hide-emphasis-markers t)

(setq org-pomodoro-keep-killed-time t)
(setq org-pomodoro-keep-killed-pomodoro-time t)
(setq org-journal-dir "~/Dropbox/journal")
(setq org-startup-folded t)

(setq org-agenda-custom-commands
      '(("3" "cis380" tags-todo "cis380")
        ("u" "urbs420" tags-todo "urbs420")
        ("i" "inbox" tags-todo "inbox")
        ))

(setq js-indent-level 2)
(setq typescript-indent-level 2)
(setq web-mode-code-indent-offset 2
      web-mode-markup-indent-offset 2)

;; (setq company-idle-delay 0)
;; (after! lsp-ui-mode ((setq lsp-ui-sideline-delay 0.5)
;;                      (setq lsp-ui-sideline-show-hover t)))
(setq +format-with-lsp nil)
(setq-default c-basic-offset 4)
(remove-hook! before-save-hook (+format-buffer-h))

(defun hello-world ()
  "My first elisp function!"
  (interactive)
  (message "Hello World!"))

(defun senior-design-terminals ()
  "Opens the terminals for senior design"
  (interactive)
  ;; Open and set up the api terminal
  (call-interactively `doom/window-maximize-buffer)
  (call-interactively `+vterm/here)
  (end-of-buffer)
  (vterm-send-string "cd ~/code/wigo/api\n")
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

(defun penn-os-terminals ()
  "Opens the terminals for penn-os"
  (interactive)
  ;; Open and set up the api terminal
  (call-interactively `doom/window-maximize-buffer)
  (call-interactively `+vterm/here)
  (end-of-buffer)
  (vterm-send-string "cd ~/code/cis380/20fa-project-2-group-14\n")
  (vterm-send-string "vagrant up && vagrant ssh\n")
  (vterm-send-string "cd /vagrant/20fa-project-2-group-14\n")

  ;; Save the window configuration and return
  (window-configuration-to-register ?a)
  (message "Done!")
  )

(map! :leader
      :desc "Open senior design terminals"  :m "o s" 'senior-design-terminals)
;; (map! :leader
;;       :desc "Open penn-os terminals"  :m "o 3" 'penn-os-terminals)

(add-hook! nov-mode
  (setq visual-fill-column-mode t)
  (setq visual-fill-column-center-text t)
  (setq line-spacing 4))

(add-hook! writeroom-mode (doom/reset-font-size))

(after! fill-column (setq visual-fill-column-center-text t))


(setq-default line-spacing 4)

(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defun magit-refresh-maybe ()
  (dolist (buf (doom-buffers-in-mode 'magit-status-mode))
    (with-current-buffer buf
      (magit-refresh-buffer))))

(run-with-idle-timer 3 t #'magit-refresh-maybe)
