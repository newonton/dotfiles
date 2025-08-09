# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

source $ZSH/zsh/colors.sh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

_git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

_git_dirty() {
  if ! $git status -s &> /dev/null; then
    echo ""
    return
  fi

  local git_status="$($git status --porcelain)"
  if [[ -z "$git_status" ]]; then
    echo "${C[brightblack]}$(_git_prompt_info)${C[reset]}"
  elif echo "$git_status" | grep -q '^[AMDRCU]'; then
    echo "${C[yellow]}$(_git_prompt_info)${C[reset]}"
  else
    echo "${C[red]}$(_git_prompt_info)${C[reset]}"
  fi
}

_git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

# This assumes that you always have an origin named `origin`, and that you only
# care about one specific origin. If this is not the case, you might want to use
# `$git cherry -v @{upstream}` instead.
_need_push () {
  if [ $($git rev-parse --is-inside-work-tree 2>/dev/null) ]
  then
    number=$($git cherry -v origin/$(git symbolic-ref --short HEAD) 2>/dev/null | wc -l | bc)

    if [[ $number == 0 ]]
    then
      echo ""
    else
      echo " ${C[brightblack]}$number↑${C[reset]}"
    fi
  fi
}

# This assumes that you always have an origin named `origin`, and that you only
# care about one specific origin. If this is not the case, you might want to
# use `$git rev-list --count @{upstream}..HEAD` or other upstream-aware checks.
_need_pull () {
  if [ $($git rev-parse --is-inside-work-tree 2>/dev/null) ]
  then
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    # количество коммитов в origin/branch, которых нет в локальной ветке
    number=$($git rev-list --count HEAD..origin/"$branch" 2>/dev/null)

    if [[ -z "$number" || "$number" == "0" ]]
    then
      echo ""
    else
      echo "${C[brightblack]}$number↓${C[reset]}"
    fi
  fi
}

_git_all() {
  if ! $git status -s &> /dev/null
  then
    echo ""
    return
  fi

  echo "${C[brightblack]}<${C[reset]}$(_git_dirty)$(_need_push)$(_need_pull)${C[brightblack]}>${C[reset]}"
}

_dir_name() {
  echo "${C[white]}%1/%\/${C[reset]}"
}

_dir_full() {
  echo "${C[white]}%~${C[reset]}"
}

_battery_status() {
  if test ! "$(uname)" = "Darwin"
  then
    exit 0
  fi

  if [[ $(sysctl -n hw.model) == *"Mac"* ]]
  then
    $ZSH/bin/battery-status
  fi
}

_logo() {
  echo "${C[brightblack]}${C[reset]}"
}

_username() {
  echo "${C[red]}%n${C[reset]}"
}

_time() {
  echo "${C[white]}%D{%I:%M:%S}${C[reset]}"
}

_right_align_time() {
  echo "%{$terminfo[sc]%}%{$(echoti hpa $((COLUMNS - 8)))%}$(_time)%{$terminfo[rc]%}"
}

PROMPT=$"$(_logo) $(_username) $(_dir_full) $(_git_all) $(_right_align_time)\n${C[red]}~>${C[reset]} "
