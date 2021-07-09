;;; ac-contact.el --- auto complete contact -*- lexical-binding: t; -*-

;; Copyright (C) 2018 by Matthias David

;; Author:  Matthias David
;; Version: 0.0.1
;; Package-Requires: ((auto-complete "1.5") (cl-lib 0.5))

;;; Commentary:
;; To use this package, add following code to your init.el or .emacs
;;
;;    (eval-after-load "auto-complete"
;;      '(progn
;;          (ac-conatct-setup)))
;;
;;    (add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
;;    (add-hook 'mail-mode-hook 'ac-ispell-ac-setup)

;;; Code:
(require 'auto-complete)
(require 'bbdb)
(require 'cl-lib)

(defgroup ac-contact nil
  "Auto completion with bbdb."
  :group 'auto-complete)

(defface ac-contact-candidate-face
  '((t (:inherit ac-candidate-face :foreground "DarkGreen")))
  "Face for fuzzy candidate."
  :group 'ac-contact)

(defcustom ac-contact-requires 3
  "Minimum input for starting completion."
  :type 'integer
  :group 'ac-contact)

(defun ac-contact-candidate ()
  "Candidate."
    (cl-loop for bbdb-record in (bbdb-records)
	   for name = (bbdb-record-name bbdb-record)
	   collect (cons name bbdb-record))

    ;; (delete-dups
    ;;  (apply
    ;;   'append
    ;;   (mapcar (lambda (rec)
    ;; 		(mapcar (lambda (n) (bbdb-mail-address rec n))
    ;; 			(bbdb-record-name rec)))
    ;;           (bbdb-records))))
  )



;;;###autoload
(defun ac-contact-setup ()
  "Declare auto-complete source."
  (interactive)
  (add-to-list 'ac-sources 'ac-source-contact) )

  (ac-define-source contact
		    '((candidates . ac-contact-candidate)
		      (match . substring)
		      (candidate-face . ac-contact-candidate-face)
		      (requires . ,ac-contact-requires)
		      (symbol . "C")))


(provide 'ac-contact)
;;; ac-contact.el ends here
