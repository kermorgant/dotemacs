;; setup org
(use-package org
  :ensure org
  :diminish org-indent-mode
  :init
  ;; default directory
  (setq org-directory "~/Dropbox/org")
  ;; hide markup
  (setq org-hide-emphasis-markers t)
  ;; minimal outlines
  (setq org-startup-indented t
	org-hide-leading-stars t)
  ;; image handling
  (setq org-image-actual-width '(300))
  ;; syntax for codes
  (setq org-src-fontify-natively t
	org-src-tab-acts-natively t)
  ;; exporting
  (setq org-export-with-smart-quotes t
	org-export-backends '(beamer html latex md))
  ;; syntax highligting in LaTeX documents
  ;; (require 'ox-latex)
  ;; (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)
  ;; Let the exporter use the -shell-escape option to let latex
  ;; execute external programs.
  ;; This obviously and can be dangerous to activate!
  (setq org-latex-minted-options
	'(("mathescape" "true")
	  ("linenos" "true")
	  ("numbersep" "5pt")
	  ("frame" "lines")
	  ("framesep" "2mm")))
  (setq org-latex-pdf-process
	'("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  ;; tags
  (setq org-tag-alist (quote (("article"   . ?a)
			      ("courses"   . ?o)
			      ("code"      . ?c)
			      ("errands"   . ?e)
			      ("blog"      . ?b)
			      ("idea"      . ?d)
			      ("job"       . ?j)
			      ("meeting"   . ?m)
			      ("note"      . ?n)
			      ("personal"  . ?i)
			      ("gubby"     . ?g)
			      ("reading"   . ?r)
			      ("project"   . ?p)
			      ("reveal"    . ?l)
			      ("vague"     . ?v)
			      ("work"      . ?w)
			      ("noexport"  . ?x))))
  ;; todo states
  (setq org-todo-keywords
	'((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE(d!)")
	  (sequence "WAITING(w@/!)" "|" "CANCELED(c@)")))
  ;; agenda files
  (setq org-agenda-files (list
			  "~/Dropbox/org/errands.org"
			  "~/Dropbox/org/phd.org"
			  "~/Dropbox/org/articles.org"
			  "~/Dropbox/org/notes.org"
			  "~/Dropbox/org/blog.org"))
  ;; deadline handling
  (setq org-deadline-warning-days 7
	org-agenda-span 'fortnight
	org-agenda-skip-scheduled-if-deadline-is-shown t)
  ;; capture templates - brace yourselves
  (setq org-capture-templates '(
				;; For notes on articles
				("a"	    ; key
				 "Articles" ; name
				 entry	    ; type
				 (file+headline "~/Dropbox/org/phd.org" "Articles") ; target
				 "* %? %(org-set-tags)  :article:\n:PROPERTIES:\n:Created: %U\n:Linked: %A\n:END:\n%i" ; template
				 :prepend t	 ; properties
				 :empty-lines 1	 ; properties
				 :created t	 ; properties
				 :kill-buffer t) ; properties
				;; For code snippets
				("c"	; key
				 "Code"	; name
				 entry	; type
				 (file+headline "~/Dropbox/org/notes.org" "Code") ; target
				 "* %^{TITLE} %(org-set-tags)  :code:\n:PROPERTIES:\n:Created: %U\n:END:\n%i\#+BEGIN_SRC %^{language}\n%?\n\#END_SRC" ; template
				 :prepend t	 ; properties
				 :empty-lines 1	 ; properties
				 :created t	 ; properties
				 :kill-buffer t) ; properties
				;; For taking notes on random things
				("n"	; key
				 "Note"	; name
				 entry	; type
				 (file+headline "~/Dropbox/org/notes.org" "Notes") ; target
				 "* %? %(org-set-tags)  :note:\n:PROPERTIES:\n:Created: %U\n:Linked: %A\n:END:\n%i" ; template
				 :prepend t	 ; properties
				 :empty-lines 1	 ; properties
				 :created t	 ; properties
				 :kill-buffer t) ; properties
				;; Blogging ideas
				("b"	; key
				 "Blog" ; name
				 entry	; type
				 (file+headline "~/Dropbox/org/blog.org" "Blog") ; target
				 "* %? %(org-set-tags)  :blog:\n:PROPERTIES:\n:Created: %U\n:Linked: %A\n:END:\n%i" ; template
				 :prepend t	 ; properties
				 :empty-lines 1	 ; properties
				 :created t	 ; properties
				 :kill-buffer t) ; properties
				;; Stuff to read
				("r"	   ; key
				 "Reading" ; name
				 entry	   ; type
				 (file+headline "~/Dropbox/org/notes.org" "Reading") ; target
				 "* %? %(org-set-tags)  :reading:\n:PROPERTIES:\n:Created: %U\n:Linked: %A\n:END:\n%i" ; template
				 :prepend t	 ; properties
				 :empty-lines 1	 ; properties
				 :created t	 ; properties
				 :kill-buffer t) ; properties
				;; For potating
				("g"	 ; key
				 "Gubby" ; name
				 entry	 ; type
				 (file+headline "~/Dropbox/org/potato.org" "Gubby") ; target
				 "* %? %(org-set-tags)  :gubby:\n:PROPERTIES:\n:Created: %U\n:Linked: %A\n:END:\n%i" ; template
				 :prepend t	 ; properties
				 :empty-lines 1	 ; properties
				 :created t	 ; properties
				 :kill-buffer t) ; properties
				;; For notes or something regarding more work
				("w"	; key
				 "Work"	; name
				 entry	; type
				 (file+headline "~/Dropbox/org/phd.org" "Work")	; target
				 "* TODO %^{Todo} %(org-set-tags)  :work:\n:PROPERTIES:\n:Created: %U\n:END:\n%i\n%?" ; template
				 :prepend t	 ; properties
				 :empty-lines 1	 ; properties
				 :created t	 ; properties
				 :kill-buffer t) ; properties
				;; For capturing minutes of the meeting
				("m"	   ; key
				 "Meeting" ; name
				 entry	   ; type
				 (file+datetree "~/Dropbox/org/phd.org" "Meeting") ; target
				 "* %^{Title} %(org-set-tags)  :meeting:\n:PROPERTIES:\n:Created: %U\n:END:\n%i\n** Agenda:\n%?\n\n** Minutes of the meeting:\n" ; template
				 :prepend t	 ; properties
				 :empty-lines 1	 ; properties
				 :created t	 ; properties
				 :kill-buffer t) ; properties
				;; For capturing details of a job application/details
				("j"	    ; key
				 "Jobs"	    ; name
				 table-line ; type
				 (file+headline "~/Dropbox/org/notes.org" "Jobs") ; target
				 "| %u | %^{Company} | [[%^{job link}][%^{position}]] | %^{referrals?} | %^{Experience?} | %^t | %^{Status} | %^{Follow up} | %^{Result} |" ; template
				 :prepend t ; properties
				 ;; :table-line-pos "II-3"   ; properties
				 :empty-lines 1	 ; properties
				 :created t	 ; properties
				 :kill-buffer t) ; properties
				;; To capture tons of errands
				("e"	   ; key
				 "Errands" ; name
				 entry	   ; type
				 (file+headline "~/Dropbox/org/errands.org" "Errands") ; target
				 "* TODO %^{Todo} %(org-set-tags)  :errands:\n:PROPERTIES:\n:Created: %U\n:END:\n%i\n%?" ; template
				 :prepend t	 ; properties
				 :empty-lines 1	 ; properties
				 :created t	 ; properties
				 :kill-buffer t) ; properties
				;; To capture things regarding my course
				("o"	   ; key
				 "Courses" ; name
				 entry	   ; type
				 (file+headline "~/Dropbox/org/phd.org" "Courses") ; target
				 "* %^{Course} %(org-set-tags)  :courses:\n:PROPERTIES:\n:Created: %U\n:END:\n%i\n%?" ; template
				 :prepend t        ; properties
				 :empty-lines 1    ; properties
				 :created t        ; properties
				 :kill-buffer t))) ; properties
  ;; refiling
  (setq org-refile-targets '((nil :maxlevel . 9)
			     (org-agenda-files :maxlevel . 9)))
  (setq org-refile-use-outline-path t
	org-outline-path-complete-in-steps nil)

  :config
  ;; worf mode for super fast org navigation
  (use-package worf
    :ensure t
    :config
    (add-hook 'org-mode-hook 'worf-mode))
  ;; mark inside subtree
  (defun sk/mark-inside-subtree ()
    (interactive)
    (org-mark-subtree)
    (next-line 1))
  ;; babel
  (use-package babel
    :ensure t
    :init
    (setq org-confirm-babel-evaluate nil)
    :defer t
    :config
    (use-package ob-ipython
      :ensure t
      :defer t))
  ;; interleaved notes
  (use-package interleave
    :ensure t
    :commands (interleave
	       interleave-pdf-mode))
  ;; extra exports
  (use-package ox-reveal
    :ensure t
    :defer t
    :init
    (setq org-reveal-title-slide-template "<h1>%t</h1>\n<h3>%a</h3>")
    (setq org-reveal-root "file:///Users/sriramkswamy/Documents/github/reveal.js")
    (use-package htmlize
      :ensure t))
  (use-package ox-twbs
    :ensure t
    :defer t)
  (use-package ox-gfm
    :ensure t
    :defer t)
  (use-package ox-rst
    :ensure t
    :defer t)
  ;; some nice hooks for org
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)
  ;; More of those nice template expansion
  (add-to-list 'org-structure-template-alist '("A" "#+DATE: ?"))
  (add-to-list 'org-structure-template-alist '("C" "#+BEGIN_CENTER\n?\n#+END_CENTER\n"))
  (add-to-list 'org-structure-template-alist '("D" "#+DESCRIPTION: ?"))
  (add-to-list 'org-structure-template-alist '("E" "#+BEGIN_EXAMPLE\n?\n#+END_EXAMPLE\n"))
  (add-to-list 'org-structure-template-alist '("H" "#+LATEX_HEADER: ?"))
  (add-to-list 'org-structure-template-alist '("I" ":INTERLEAVE_PDF: ?"))
  (add-to-list 'org-structure-template-alist '("L" "#+BEGIN_LaTeX\n?\n#+END_LaTeX"))
  (add-to-list 'org-structure-template-alist '("M" "#+LATEX_HEADER: \\usepackage{minted}\n"))
  (add-to-list 'org-structure-template-alist '("N" "#+NAME: ?"))
  (add-to-list 'org-structure-template-alist '("P" "#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"org.css\"/>\n"))
  (add-to-list 'org-structure-template-alist '("S" "#+SUBTITLE: ?"))
  (add-to-list 'org-structure-template-alist '("T" ":DRILL_CARD_TYPE: twosided"))
  (add-to-list 'org-structure-template-alist '("V" "#+BEGIN_VERSE\n?\n#+END_VERSE"))
  (add-to-list 'org-structure-template-alist '("X" "#+EXCLUDE_TAGS: reveal?"))
  (add-to-list 'org-structure-template-alist '("a" "#+AUTHOR: ?"))
  (add-to-list 'org-structure-template-alist '("c" "#+CAPTION: ?"))
  (add-to-list 'org-structure-template-alist '("d" "#+OPTIONS: ':nil *:t -:t ::t <:t H:3 \\n:nil ^:t arch:headline\n#+OPTIONS: author:t email:nil e:t f:t inline:t creator:nil d:nil date:t\n#+OPTIONS: toc:nil num:nil tags:nil todo:nil p:nil pri:nil stat:nil c:nil d:nil\n#+LATEX_HEADER: \\usepackage[margin=2cm]{geometry}\n#+LANGUAGE: en\n\n#+REVEAL_TRANS: slide\n#+REVEAL_THEME: white\n#+REVEAL_ROOT: file:///Users/sriramkswamy/Documents/github/reveal.js\n\n?"))
  (add-to-list 'org-structure-template-alist '("e" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist '("f" "#+TAGS: @?"))
  (add-to-list 'org-structure-template-alist '("h" "#+BEGIN_HTML\n?\n#+END_HTML\n"))
  (add-to-list 'org-structure-template-alist '("i" "#+INTERLEAVE_PDF: ?"))
  (add-to-list 'org-structure-template-alist '("k" "#+KEYWORDS: ?"))
  (add-to-list 'org-structure-template-alist '("l" "#+LABEL: ?"))
  (add-to-list 'org-structure-template-alist '("m" "#+BEGIN_SRC matlab\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist '("n" "#+BEGIN_NOTES\n?\n#+END_NOTES"))
  (add-to-list 'org-structure-template-alist '("o" "#+OPTIONS: ?"))
  (add-to-list 'org-structure-template-alist '("p" "#+BEGIN_SRC python\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist '("q" "#+BEGIN_QUOTE\n?\n#+END_QUOTE"))
  (add-to-list 'org-structure-template-alist '("r" ":PROPERTIES:\n?\n:END:"))
  (add-to-list 'org-structure-template-alist '("s" "#+BEGIN_SRC ?\n#+END_SRC\n"))
  (add-to-list 'org-structure-template-alist '("t" "#+TITLE: ?"))
  (add-to-list 'org-structure-template-alist '("v" "#+BEGIN_VERBATIM\n?\n#+END_VERBATIM"))

  :general
  (general-nvmap :prefix sk--evil-global-leader
		 "o" '(nil :which-key "org")
		 "oc" '(org-capture :which-key "capture")
		 "oa" '(org-agenda :which-key "agenda"))
  (general-nvmap :prefix sk--evil-local-leader
		 "o" '(hydra-org/body :which-key "org"))
  (general-nvmap :prefix sk--evil-local-leader
		 "[" '(org-date-from-calendar :which-key "org date cal")
		 "]" '(org-goto-calendar :which-key "org goto cal")
		 "'" (general-simulate-keys "C-c '" t "org special")
		 "RET" '(org-open-at-point :which-key "org open at point"))
  (general-nmap "gO" '(org-narrow-to-subtree :which-key "org narrow"))
  (general-otomap "o" 'org-mark-subtree)
  (general-itomap "o" 'sk/mark-inside-subtree)
  (general-evil-define-key '(normal visual) org-agenda-mode-map
    "q" (general-simulate-keys "q" t "quit")
    "t" (general-simulate-keys "T" t "tags")
    "T" (general-simulate-keys "t" t "todo")
    "r" (general-simulate-keys "g" t "refresh")
    "a" (general-simulate-keys "a" t "archive")
    "b" (general-simulate-keys "b" t "previous week")
    "e" (general-simulate-keys "f" t "next week")
    "w" (general-simulate-keys "w" t "weekly week")
    "v" (general-simulate-keys "m" t "mark")
    "u" (general-simulate-keys "u" t "unmark")
    "f" (general-simulate-keys "/" t "filter")))

;; diminish org indent mode
(defun sk/diminish-org-indent ()
  (interactive)
  (diminish 'org-indent-mode ""))
(add-hook 'org-indent-mode-hook 'sk/diminish-org-indent)

;; load the extra org goodness
(defun sk/org-custom-load ()
  (interactive)
  (require 'org)
  (require 'ob)
  (require 'ox)
  ;; Some extra exports
  (require 'ox-reveal)
  (require 'ox-twbs)
  (require 'ox-rst)
  (require 'ox-gfm)
  ;; JavaScript repl support
  (require 'ob-js)
  ;; Babel load
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     ;; (dot . t)
     ;; (ditaa . t)
     (latex . t)
     ;; (gnuplot . t)
     (sh . t)
     (js . t)
     ;; (C . t)
     (ledger . t)
     ;; (R . t)
     ;; (octave . t)
     (matlab . t)
     (python . t))))

;; org hydra for template expansion
(defun hot-expand (str)
  "Expand org template."
  (insert str)
  (org-try-structure-completion))
(defhydra sk/hydra-org-template (:color blue
                                 :hint nil)
  "
 ^One liners^                                        ^Blocks^                                      ^Properties^
--------------------------------------------------------------------------------------------------------------------------------------------------------
 _a_: author        _i_: interleave  _D_: description    _C_: center      _p_: python src    _n_: notes    _d_: defaults   _r_: properties        _<_: insert '<'
 _A_: date          _l_: label       _S_: subtitle       _e_: elisp src   _Q_: quote                     _L_: latex      _I_: interleave        _q_: quit
 _c_: caption       _N_: name        _k_: keywords       _E_: example     _s_: src                       _x_: export     _T_: drill two-sided
 _f_: file tags     _o_: options     _M_: minted         _h_: html        _v_: verbatim                  _X_: noexport
 _H_: latex header  _t_: title       _P_: publish        _m_: matlab src  _V_: verse
 "
  ("a" (hot-expand "<a"))
  ("A" (hot-expand "<A"))
  ("c" (hot-expand "<c"))
  ("f" (hot-expand "<f"))
  ("H" (hot-expand "<H"))
  ("i" (hot-expand "<i"))
  ("I" (hot-expand "<I"))
  ("l" (hot-expand "<l"))
  ("n" (hot-expand "<n"))
  ("N" (hot-expand "<N"))
  ("P" (hot-expand "<P"))
  ("o" (hot-expand "<o"))
  ("t" (hot-expand "<t"))
  ("C" (hot-expand "<C"))
  ("D" (hot-expand "<D"))
  ("e" (hot-expand "<e"))
  ("E" (hot-expand "<E"))
  ("h" (hot-expand "<h"))
  ("k" (hot-expand "<k"))
  ("M" (hot-expand "<M"))
  ("m" (hot-expand "<m"))
  ("p" (hot-expand "<p"))
  ("Q" (hot-expand "<q"))
  ("s" (hot-expand "<s"))
  ("S" (hot-expand "<S"))
  ("v" (hot-expand "<v"))
  ("V" (hot-expand "<V"))
  ("x" (hot-expand "<x"))
  ("X" (hot-expand "<X"))
  ("d" (hot-expand "<d"))
  ("L" (hot-expand "<L"))
  ("r" (hot-expand "<r"))
  ("I" (hot-expand "<I"))
  ("T" (hot-expand "<T"))
  ("b" (hot-expand "<b"))
  ("<" self-insert-command)
  ("q" nil :color blue))
(defun sk/org-template-hook ()
  (define-key org-mode-map "<"
    (lambda () (interactive)
      (if (looking-back "^")
          (sk/hydra-org-template/body)
        (self-insert-command 1)))))
(add-hook 'org-mode-hook 'sk/org-template-hook)

;; organizing subtrees
(defhydra hydra-org-organize (:color red
                              :hint nil)
  "
 ^Subtree^               ^Heading^             ^Item^
^^^^^^^^^^^^^-----------------------------------------------------------------
 ^ ^ _k_ ^ ^   _a_: archive    ^ ^ _p_ ^ ^   _<_: promote  _u_: up   _q_: quit
 _h_ ^+^ _l_   _r_: refile     _b_ ^+^ _f_   _>_: demote   _d_: down
 ^ ^ _j_ ^ ^   _v_: reveal     ^ ^ _n_ ^ ^
"
  ("h" org-shiftmetaleft)
  ("l" org-shiftmetaright)
  ("j" org-metadown)
  ("k" org-metaup)
  ("b" org-metaleft)
  ("f" org-metaright)
  ("n" org-shiftmetadown)
  ("p" org-shiftmetaup)
  ("<" org-promote)
  (">" org-demote)
  ("d" org-move-item-down)
  ("u" org-move-item-up)
  ("a" org-archive-subtree :color blue)
  ("r" org-refile :color blue)
  ("v" org-reveal :color blue)
  ("q" nil :color blue))

;; hydra for org files
(defhydra hydra-org (:color pink :hint nil)
  "
 ^Link^        ^Inline^      ^Organize^          ^Subtree^     ^Meta^
 ^^^^^^^^^^^------------------------------------------------------------------------
 _s_: store    _l_: latex    _o_: organize       _x_: cut      _t_: tags    _q_ quit
 _i_: insert   _m_: images   _p_: interleave     _y_: copy     _d_: todo
 _a_: display  _h_: heading  _w_: heading dwim   _e_: export   _c_: custom load
"
  ("i" org-insert-link :color blue)
  ("s" org-store-link)
  ("a" org-toggle-link-display)
  ("o" hydra-org-organize/body :exit t)
  ("p" interleave :color blue)
  ("l" org-toggle-latex-fragment)
  ("m" org-toggle-inline-images)
  ("h" org-toggle-heading)
  ("w" org-insert-heading-respect-content)
  ("x" org-cut-subtree)
  ("y" org-copy-subtree)
  ("e" org-export-dispatch :color blue)
  ("t" org-set-tags-command :color blue)
  ("d" org-todo :color blue)
  ("c" sk/org-custom-load :color blue)
  ("q" nil :color blue))

;; provide this configuration
(provide 'sk-org)
