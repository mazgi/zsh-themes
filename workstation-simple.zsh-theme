# vim:set foldmethod=marker:
setopt transient_rprompt
setopt prompt_subst

autoload -Uz colors && colors

# Colors {{{
# see: https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
_color_pwd="244"
# }}}

PROMPT="%(?,,%F{red}[%?]%f)"
if [[ 0 -eq ${UID} ]]; then
  PROMPT+="%F{red}#%f"
fi
PROMPT+="%B"
PROMPT+="%F{244}>"
PROMPT+="%F{255}>"
PROMPT+="%F{white}>"
PROMPT+="%f%b  "
RPROMPT="%F{${_color_pwd}}%~%f"
PROMPT2="> "
