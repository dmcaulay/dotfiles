# -*- sh -*- vim:set ft=sh ai et sw=4 sts=4:
# It might be bash like, but I can't have my co-workers knowing I use zsh
PROMPT='%{$fg[green]%}%n@%m $(prompt_current_dir) $(git_prompt_info)%{$reset_color%}
%(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%}"

function prompt_current_dir {
  w=$PWD
  pre=""
  pre_color="%{$fg[magenta]%}"
  w_color="%{$fg[cyan]%}"

  if [[ $w == $HOME* ]]; then
    w="${w#$HOME}"
    pre="~"
  fi
  echo $pre_color$pre$w_color$w
}
