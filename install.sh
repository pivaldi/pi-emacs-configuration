#!/bin/bash -E

# Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>
# $Last Modified on 2011/07/03

# This program is free software ; you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation ; either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY ; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public License
# along with this program ; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA


# Set colorful only on colorful terminals.
# src: https://wiki.archlinux.org/index.php/Color_Bash_Prompt
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
    && type -P dircolors >/dev/null \
    && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

COLOR=''
NORMAL=''
if ${use_color} ; then
    COLOR="\033[46m\033[31m"
    NORMAL="\\033[0;39m"
fi

DIR=$(dirname $0)
cd $DIR
DIR="$(pwd)"

find ./*/ -iname 'makefile' -exec sh -c 'cd "$(dirname $0)" && make' "{}" ";"

EMACS_CONF="${HOME}/.emacs"
MESSAGE=''
[ -e "$EMACS_CONF" ] && {
    BACKUP_FILE="${EMACS_CONF}_$(date +%Y_%m_%d:%H-%M)"
    mv "$EMACS_CONF" "$BACKUP_FILE"
    MESSAGE="Your .emacs was backuped to $BACKUP_FILE"
}


cat >~/.emacs<<EOF
;;: -*- emacs-lisp -*-
;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>

;; This program is free software ; you can redistribute it and/or modify
;; it under the terms of the GNU Lesser General Public License as published by
;; the Free Software Foundation ; either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY ; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; Lesser General Public License for more details.

;; You should have received a copy of the GNU Lesser General Public License
;; along with this program ; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

;; Setting a variable to see if XEmacs is used
(defvar running-xemacs-p (string-match "XEmacs\|Lucid" emacs-version))

;; Depending on the version of (X) Emacs used is called the same
;; configuration files but from different directories.
(if running-xemacs-p
    (progn
      ;; XEmacs backwards compatibility file
      (setq user-init-file
            (expand-file-name "init.el"
                              (expand-file-name ".xemacs" "~")))
      (setq custom-file
            (expand-file-name "custom.el"
                              (expand-file-name ".xemacs" "~"))))
  (progn
    ;; Emacs
    (if (> emacs-major-version 21)
        (setq user-init-file (expand-file-name "${DIR}/init.el")) ;;Emacs > 21
      (setq user-init-file (expand-file-name "~/emacs-21.d/init.el"))) ;;Emacs <= 21
    ))

(load-file user-init-file)
EOF

echo -e "${COLOR}"
echo '!!=='
[ MESSAGE != '' ] && echo " * $MESSAGE"
echo ' * Remember to put your identity and customize some parameters in the file :'
echo "   ${DIR}/my-parameters.el"
echo ' * You can learn about shortkey and the necessary files to your needs in the file :'
echo "   ${DIR}/init.el"
echo -e "==!!${NORMAL}"

chmod u+x "${DIR}/bin/*"