;; Copyright (c) 2012, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-erc.el,v 0.0 2012/05/09 09:25:37 Exp $
;; $Last Modified on 2012/05/09 09:25:37

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Commentary:

;; THANKS:

;; BUGS:

;; INSTALLATION:

;; Code:



(eval-when-compile
  (require 'cl))

(setq erc-autojoin-channels-alist
      '(("irc.geeknode.org" "#rcv")
        ;; ("oftc.net" "#bitlbee")
        ))
;; (erc :server "irc.geeknode.org" :port 6667 :nick "pi")

(autoload 'erc-nick-notify-mode "erc-nick-notify"
  "Minor mode that calls `erc-nick-notify-cmd' when his nick gets
mentioned in an erc channel" t)
(eval-after-load 'erc '(erc-nick-notify-mode t))

(provide 'pi-erc)
;;; pi-erc.el ends here

;; Local variables:
;; coding: utf-8
;; End:

