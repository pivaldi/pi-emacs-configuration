(when (locate-library "emms")
  (require 'emms-setup)
  (emms-standard)
  (emms-default-players)
  ;; Show the current track each time EMMS
  ;; starts to play a track with "NP : "
  (add-hook 'emms-player-started-hook 'emms-show)
  (setq emms-show-format "NP: %s")
  )
