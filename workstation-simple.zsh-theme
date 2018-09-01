autoload -Uz vcs_info
autoload -Uz colors && colors

UID_COLOR=${fg[green]}
case ${UID} in
0)
  UID_COLOR=${fg[red]}
  ;;
*)
  ;;
esac

HOST_COLOR=0
I=0
for c in $(hostname | awk '{len=split($0,str,""); for(i=1; i<=len; i++){print str[i]}}')
do
  HOST_COLOR=$((${HOST_COLOR} + $(printf "%d" "'${c}")))
  I=$((${I} + 1))
done;
HOST_COLOR="$(printf "%%F{%03d}@%%f" "$((${HOST_COLOR} / ${I}))")"

zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT="[%{$UID_COLOR%}%n%{${reset_color}%}${HOST_COLOR}%{$reset_color%}%m] %(!.#.$) "
PROMPT2="%{${fg[blue]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%1(v|%F{green}%1v%f|) %{${fg[blue]}%}[%~]%{${reset_color}%}"
