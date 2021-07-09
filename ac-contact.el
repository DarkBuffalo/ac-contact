;;; ac-contact.el --- auto complete contact -*- lexical-binding: t; -*-

;; Copyright (C) 2021 by Matthias David

;; Author:  Matthias David
;; Version: 0.0.1
;; Package-Requires: ((auto-complete "1.5") (cl-lib 0.5) (bbdb))

;;; Commentary:

;;; Code:
(require 'auto-complete)
(require 'bbdb)
(require 'cl-lib)

(defgroup ac-contact nil
  "Auto completion with bbdb."
  :group 'auto-complete)

(defface ac-contact-candidate-face
  '((t (:inherit ac-candidate-face :foreground "green")))
  "Face for fuzzy candidate."
  :group 'ac-contact)

(defcustom ac-contact-requires 2
  "Minimum input for starting completion."
  :type 'integer
  :group 'ac-contact)

(defun ac-contact-candidate ()
  "Candidate from bbdb."
    (cl-loop for bbdb-record in (bbdb-records)
	   for name = (bbdb-record-name bbdb-record)
	   collect (cons name bbdb-record)))

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
