# user, host, full path, and time/date
# on two lines for easier vgrepping
# entry in a nice long thread on the Arch Linux forums: http://bbs.archlinux.org/viewtopic.php?pid=521888#p521888

PROMPT='
%B%{$fg_bold[white]%}%{$reset_color%}╭─{ %{$fg[blue]%}%m %{$fg_bold[white]%}%{$reset_color%}}───────〔 %{$fg[white]%}%4~%{$fg_bold[blue]%} $(git_prompt_info)%{$reset_color%}%{$fg_bold[white]%}${${KEYMAP/vicmd/--NORMAL--}/(main|viins)/--INSERT--}%{$reset_color%}〕───────{ %{$fg[yellow]%}'%D{"%a %b %d, %I:%M"}%b$'
%g%{$fg_bold[white]%}%{$reset_color%}╰─%{$fg_bold[blue]%}● %{$reset_color%}'

# RPROMPT=$'%b%{$fg[black]%}%B$(git_prompt_info) %{$reset_color%}%{$fg_bold[white]%}${${KEYMAP/vicmd/--NORMAL--}/(main|viins)/--INSERT--}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
