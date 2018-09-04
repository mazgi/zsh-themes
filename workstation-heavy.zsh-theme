# vim:set foldmethod=marker:
setopt transient_rprompt
setopt prompt_subst

PERIOD=2
add-zsh-hook precmd __precmd_render_prompt
add-zsh-hook periodic __periodic_render_rprompt

autoload -Uz colors && colors
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git

# VCS {{{
# from https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/wedisagree.zsh-theme
# git_prompt_status
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✚" # ⓐ ⑃
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ⚡"  # ⓜ ⑁
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖" # ⓧ ⑂
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➜" # ⓡ ⑄
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ♒" # ⓤ ⑊
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[blue]%} 𝝙"

# git_prompt_info
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ☂" # Ⓓ
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭" # ⓣ
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ☀" # Ⓞ
# }}}

# Colors {{{
# see: https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
_colors_prompt_mark=(
"160" # d70000
"047" # 00ff5f
"026" # 005fd7
"196" # ff0000
"178" # dfaf00
"061" # 5f5faf
"161" # d7005f
"098" # 875fd7
"119" # 87ff5f
"166" # d75f00
"021" # 0000ff
"162" # d70087
"172" # d78700
"093" # 8700ff
"green"
"magenta"
"yellow"
"cyan"
)

_color_pwd="244"
_color_sha="111"
# }}}

# --------------------------------
# PROMPT
__precmd_render_prompt () {
  local _head=${_colors_prompt_mark[1]}
  shift _colors_prompt_mark
  _colors_prompt_mark=($_colors_prompt_mark $_head)

  PROMPT="%(?,,%F{red}[%?]%f)"
  if [[ 0 -eq ${UID} ]]; then
    PROMPT+="%F{red}#%f"
  fi
  PROMPT+="%B"
  PROMPT+="%F{${_colors_prompt_mark[1]}}>"
  PROMPT+="%F{${_colors_prompt_mark[2]}}>"
  PROMPT+="%F{${_colors_prompt_mark[3]}}>"
  PROMPT+="%f%b  "
}

# --------------------------------
# RPROMPT
__periodic_render_rprompt () {
  LANG=en_US.UTF-8 vcs_info
  RPROMPT="%F{${_color_pwd}}%~%f : $(git_prompt_status) $(git_prompt_info) %F{${_color_sha}}$(git_prompt_short_sha)%f"
}

PROMPT2="> "
