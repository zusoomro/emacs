;; place your private configuration here! remember, you do not need to run 'doom
;; sync' after modifying this file!

;; some functionality uses this to identify you, e.g. gpg configuration, email
;; clients, file templates and snippets.
(setq user-full-name "zulfiqar soomro"
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
(setq doom-font (font-spec :family "Fira code" :size 13)
      doom-variable-pitch-font (font-spec :family "ETBembo" :size 16))

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

(add-hook! nov-mode
  (setq visual-fill-column-mode t)
  (setq visual-fill-column-center-text t)
  (setq line-spacing 4))

(add-hook! writeroom-mode (doom/reset-font-size))

(after! fill-column (setq visual-fill-column-center-text t))

;; configure ivy posframe
;; (after! ivy-posframe
;;   (setf (alist-get t ivy-posframe-display-functions-alist)
;;         #'ivy-posframe-display-at-frame-top-center))
(after! ivy-posframe
  (ivy-posframe-mode -1))

(setq-default line-spacing 4)

(setq evil-vsplit-window-right t
      evil-split-window-below t)

(setq js-indent-level 2)
(setq typescript-indent-level 2)
(setq web-mode-code-indent-offset 2
      web-mode-markup-indent-offset 2)

(setq company-idle-delay 0)
(after! lsp-ui-mode ((setq lsp-ui-sideline-delay 0.5)
                     (setq lsp-ui-sideline-show-hover t)))
(setq +format-with-lsp nil)
(setq-default c-basic-offset 4)

(setq org-roam-directory "~/Dropbox/notes")
(setq visual-fill-column-center-text t)

(add-hook! org-mode (visual-fill-column-mode))

(defun magit-refresh-maybe ()
  (dolist (buf (doom-buffers-in-mode 'magit-status-mode))
    (with-current-buffer buf
      (magit-refresh-buffer))))

(run-with-idle-timer 3 t #'magit-refresh-maybe)

(setq +mu4e-mu4e-mail-path "~/mail")
;; Each path is relative to `+mu4e-mu4e-mail-path', which is ~/.mail by default
(set-email-account! "me@zusoomro.com"
                    '((mu4e-sent-folder       . "/mailbox/Sent")
                      (mu4e-drafts-folder     . "/mailbox/Drafts")
                      (mu4e-trash-folder      . "/mailbox/Trash")
                      (mu4e-refile-folder     . "/mailbox/INBOX")
                      (smtpmail-smtp-user     . "me@zusoomro.com")
                      (user-mail-address      . "me@zusoomro.com"))    ;; only needed for mu < 1.4
                    t)
(setq
 message-send-mail-function   'smtpmail-send-it
 smtpmail-default-smtp-server "smtp.fastmail.com"
 smtpmail-smtp-server         "smtp.fastmail.com")
