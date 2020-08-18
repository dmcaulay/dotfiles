# -*- sh -*- vim:set ft=sh ai et sw=4 sts=4:
# It might be bash like, but I can't have my co-workers knowing I use zsh
PROMPT='%{$fg_bold[green]%}%n@%m $(prompt_current_dir) $(git_prompt_info)%{$reset_color%}
%(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[red]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%}"

function prompt_current_dir {
  w=$PWD
  pre=""
  pre_color="%{$fg_bold[magenta]%}"
  w_color="%{$fg_bold[cyan]%}"

  for gohost in $KNOWN_GOHOSTS; do
    w="${w/$gohost\//}"
  done

  if [[ $w == "$GOPATH/src/"* ]]; then
    w="${w#$GOPATH/src/}"
    pre="go/"
  else
    if [[ $w == $HOME* ]]; then
      w="${w#$HOME}"
      pre="~"
    fi
  fi
  echo $pre_color$pre$w_color$w
}
