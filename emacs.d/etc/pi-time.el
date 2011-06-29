;; -----------------------
;; * La date en français *
;; Affiche l'heure dans la ligne de mode.
(display-time)
;; Nom en clair des jours et mois apparaissant dans le calendrier
(setq calendar-day-abbrev-array
      ["dim" "lun" "mar" "mer" "jeu" "ven" "sam"])
(setq calendar-day-name-array
      ["dimanche" "lundi" "mardi" "mercredi" "jeudi" "vendredi" "samedi"])
(setq calendar-month-abbrev-array
      ["jan" "fév" "mar" "avr" "mai" "jun"
       "jul" "aoû" "sep" "oct" "nov" "déc"])
(setq calendar-month-name-array
      ["janvier" "février" "mars" "avril" "mai" "juin"
       "juillet" "août" "septembre" "octobre" "novembre" "décembre"])

;; Source: http://kib2.free.fr/Articles/Emacs_my_love.html
;; Heure-Dates
(display-time)
(setq european-calendar-style t
      display-time-day-and-date t
      display-time-24hr-format t
      calendar-week-start-day 1)

;; vacances
(setq mark-holidays-in-calendar t
      general-holidays nil
      hebrew-holidays nil
      islamic-holidays nil
      bahai-holidays nil
      oriental-holidays nil)
(setq local-holidays
      '((holiday-fixed 5 1 "Fête du travail")
        (holiday-fixed 5 8 "Victoire 1945")
        (holiday-fixed 7 14 "Fête nationale")
        (holiday-fixed 8 15 "Assomption")
        (holiday-fixed 11 1 "Toussaint")
        (holiday-fixed 11 11 "Armistice 1918")
        (holiday-float 5 0 2 "Fête des mères")
        (holiday-float 6 0 3 "Fête des pères")))

;; voir les entrees de diary dans LaTeX calendar
(setq cal-tex-diary t)
;; fancy diary display
(add-hook 'diary-display-hook 'fancy-diary-display)
;; LaTeX calendar hook
;; Pour obtenir une sortie latex du calendrier: M-x cal-tex-cursor <tab>
(add-hook 'cal-tex-hook 'pi-calendrier)
(defun pi-calendrier ()
  "Se charge d'ajouter des options après avoir trouvé la ligne \\documentclass."
  (goto-char (point-min))
  (search-forward-regexp "^\\\\documentclass" 500)
  (beginning-of-line 2)
  (insert "\\usepackage[latin1]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{lmodern}
\\usepackage[a4paper,landscape,margin=2cm]{geometry}
"))

;; Local variables:
;; coding: utf-8
;; End:
