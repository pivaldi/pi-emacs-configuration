(when (require 'ecb nil t) ;; ECB is packaged by debian
  ;; Desable semantic-idle-scheduler. Does not work with php 5
  (global-semantic-idle-scheduler-mode -1)
  ;; Default value is 2 but smantic does not work with php5
  ;; (setq semantic-idle-scheduler-idle-time 20)

  (ecb-layout-define "h" left nil
                     ;; The frame is already splitted side-by-side and point stays in the
                     ;; left window (= the ECB-tree-window-column)

                     ;; Here is the creation code for the new layout

                     ;; 1. Defining the current window/buffer as ECB-methods buffer
                     (ecb-set-methods-buffer)
                     ;; 2. Splitting the ECB-tree-windows-column in two windows
                     (ecb-split-ver 0.75 t)
                     ;; 3. Go to the second window
                     (other-window 1)
                     ;; 4. Defining the current window/buffer as ECB-history buffer
                     (ecb-set-history-buffer)
                     ;; 5. Make the ECB-edit-window current (see Postcondition above)
                     (select-window (next-window)))

  (setq ecb-other-window-behavior (quote all)))
