# Script to enable helper functions for setting keyboard.

function eq {
  if [ "$EMACS_QMK" ]
  then
    echo Unsetting EMACS_QMK
    unset EMACS_QMK
  else
    echo Setting EMACS_QMK
    export EMACS_QMK=1
  fi
}
