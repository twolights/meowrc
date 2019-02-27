# vim: syntax=zsh
if [ $UID -eq 0 ]; then NCOLOR="yellow"; else NCOLOR="white"; fi

function my_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

if [ $WINDOW ]; then
    PROMPT='%{$fg_bold[$NCOLOR]%}%n%{$reset_color%}@%m [%{$fg_bold[white]%}%~%{$reset_color%}] %{$fg_bold[blue]%}$(my_git_prompt_info)%{$reset_color%}%{$fb_bold[white]%}[W$WINDOW] %{$reset_color%}'
else
    PROMPT='%{$fg_bold[$NCOLOR]%}%n%{$reset_color%}@%m [%{$fg_bold[white]%}%~%{$reset_color%}] %{$fg_bold[blue]%}$(my_git_prompt_info)%{$reset_color%}'
fi

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="] "
# ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
# ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"
