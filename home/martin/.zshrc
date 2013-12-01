# Workaround for vte overriding $TERM
if [[ ${TERM} == "xterm" ]]; then
  export TERM="xterm-256color"
fi

if [ "$TERM" = "linux" ]; then
  echo -en "\e]P0002b36"
  echo -en "\e]P1073642"
  echo -en "\e]P2586E75"
  echo -en "\e]P3657B83"
  echo -en "\e]P4FDF6E3"
  echo -en "\e]P5EEE8D5"
  echo -en "\e]P693A1A1"
  echo -en "\e]P7839496"
  echo -en "\e]P8CB4B16"
  echo -en "\e]P9DC322F"
  echo -en "\e]PA719E07"
  echo -en "\e]PBB58900"
  echo -en "\e]PC268BD2"
  echo -en "\e]PDD33682"
  echo -en "\e]PE2AA198"
  echo -en "\e]PF6C71C4"
  clear #for background artifacting
fi

if (( $(tput colors) == 256 )); then
  if (( EUID == 0 )); then
    Z_C_USR="[38;5;9m"
  else
    Z_C_USR="[38;5;10m"
  fi
  Z_C_BG="[48;5;4m"
  Z_C_DRK="[48;5;5m"
  Z_C_NT="[38;5;6m"
  Z_C_PWD="[38;5;15m"
  Z_C_ERR="[38;5;8m"
  Z_C_MSG="[38;5;11m"
  Z_C_GIT="[38;5;12m"
  Z_C_OPT="[38;5;13m"
  Z_C_PAR="[38;5;14m"
  Z_C_STA="[38;5;6m"
  Z_C_END="[0m"

  GREP_COLORS="mt=38;5;226:ms=38;5;214:mc=38;5;217:sl=:cx=:fn=38;5;228"
  GREP_COLORS+=":ln=38;5;190:bn=38;5;118:se=38;5;123"
  eval $(dircolors ~/.zsh/256.dircolors)

else
  if (( EUID == 0 )); then
    Z_C_USR="[1;31m"
  else
    Z_C_USR="[1;32m"
  fi
  Z_C_BG="[44m"
  Z_C_DRK="[45m"
  Z_C_NT="[1;36m"
  Z_C_PWD="[1;37m"
  Z_C_ERR="[1;30m"
  Z_C_MSG="[1;33m"
  Z_C_GIT="[1;34m"
  Z_C_OPT="[1;35m"
  Z_C_PAR="[1;36m"
  Z_C_STA="[1;44;33m"
  Z_C_END="[0m"

  GREP_COLORS="mt=1;31:ms=1;31:mc=1;31:sl=:cx=:fn=1;35:ln=1;32:bn=1;32:se=1;36"
  eval $(dircolors ~/.zsh/16.dircolors)
fi

setopt append_history
setopt share_history
setopt extended_history
setopt histignorealldups
setopt histignorespace
setopt auto_cd
setopt extended_glob
setopt longlistjobs
setopt nonomatch
setopt notify
setopt hash_list_all
setopt completeinword
setopt nohup
setopt auto_pushd
setopt nobeep
setopt pushd_ignore_dups
setopt noglobdots
setopt noshwordsplit
setopt unset

source .zsh/paths.sh
export PATH="/home/martin/Util:$PATH"
export EDITOR="vim"
export PAGER="less"
export SHELL='/bin/zsh'
export BROWSER="google-chrome"

export GREP_COLORS
export LS_COLORS
export LESS_TERMCAP_mb=$Z_C_MSG
export LESS_TERMCAP_md=$Z_C_OPT
export LESS_TERMCAP_me=$Z_C_END
export LESS_TERMCAP_se=$Z_C_END
export LESS_TERMCAP_so=$Z_C_STA
export LESS_TERMCAP_ue=$Z_C_END
export LESS_TERMCAP_us=$Z_C_PAR

REPORTTIME=5
watch=(notme root)

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

bindkey -M vicmd "$terminfo[kdch1]" vi-delete-char
bindkey -M vicmd "$terminfo[khome]" vi-beginning-of-line
bindkey -M vicmd "$terminfo[kend]"  vi-end-of-line
bindkey -M viins "$terminfo[kdch1]" vi-delete-char
bindkey -M viins "$terminfo[cuu1]"  vi-up-line-or-history
bindkey -M viins "$terminfo[cuf1]"  vi-forward-char
bindkey -M viins "$terminfo[kcuu1]" vi-up-line-or-history
bindkey -M viins "$terminfo[kcud1]" vi-down-line-or-history
bindkey -M viins "$terminfo[kcuf1]" vi-forward-char
bindkey -M viins "$terminfo[kcub1]" vi-backward-char

bindkey -v

## beginning-of-line OR beginning-of-buffer OR beginning of history
## by: Bart Schaefer <schaefer@brasslantern.com>, Bernhard Tittelbach
beginning-or-end-of-somewhere() {
  local hno=$HISTNO
  if [[ ( "${LBUFFER[-1]}" == $'\n' && "${WIDGET}" == beginning-of* ) || \
    ( "${RBUFFER[1]}" == $'\n' && "${WIDGET}" == end-of* ) ]]; then
    zle .${WIDGET:s/somewhere/buffer-or-history/} "$@"
  else
    zle .${WIDGET:s/somewhere/line-hist/} "$@"
    if (( HISTNO != hno )); then
      zle .${WIDGET:s/somewhere/buffer-or-history/} "$@"
    fi
  fi
}
zle -N beginning-of-somewhere beginning-or-end-of-somewhere
zle -N end-of-somewhere beginning-or-end-of-somewhere

bindkey '\eOH' beginning-of-somewhere  # home
bindkey '[H' beginning-of-somewhere  # home
bindkey '\eOF' end-of-somewhere        # end
bindkey '[F' end-of-somewhere        # end

bindkey '\e[A'  up-line-or-search       # cursor up
bindkey '\e[B'  down-line-or-search     # <ESC>-

## use Ctrl <- and Ctrl -> for jumping to word-beginnings on the CL
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
## the same for alt-left-arrow and alt-right-arrow
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end  history-search-end
bindkey '^xp'   history-beginning-search-backward-end
bindkey '^xP'   history-beginning-search-forward-end
bindkey "\e[5~" history-beginning-search-backward-end # PageUp
bindkey "\e[6~" history-beginning-search-forward-end  # PageDown

autoload -U insert-unicode-char
zle -N insert-unicode-char
bindkey '^xi' insert-unicode-char

bindkey "$terminfo[kcbt]" reverse-menu-complete

NOABBREVIATION=${NOABBREVIATION:-0}
grml_toggle_abbrev() {
  if (( ${NOABBREVIATION} > 0 )) ; then
    NOABBREVIATION=0
  else
    NOABBREVIATION=1
  fi
}
zle -N grml_toggle_abbrev
bindkey '^xA' grml_toggle_abbrev

commit-to-history() {
  print -s ${(z)BUFFER}
  zle send-break
}
zle -N commit-to-history
bindkey "^x^h" commit-to-history

# only slash should be considered as a word separator:
slash-backward-kill-word() {
  local WORDCHARS="${WORDCHARS:s@/@}"
  zle backward-kill-word
}
zle -N slash-backward-kill-word

bindkey '\ev' slash-backward-kill-word
bindkey '\e^h' slash-backward-kill-word
bindkey '\e^?' slash-backward-kill-word

bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

zstyle ':acceptline:*' rehash true
function Accept-Line() {
  setopt localoptions noksharrays
  local -a subs
  local -xi aldone
  local sub
  local alcontext=${1:-$alcontext}

  zstyle -a ":acceptline:${alcontext}" actions subs

  (( ${#subs} < 1 )) && return 0

  (( aldone = 0 ))
  for sub in ${subs} ; do
    [[ ${sub} == 'accept-line' ]] && sub='.accept-line'
    zle ${sub}
    (( aldone > 0 )) && break
  done
}
function Accept-Line-getdefault() {
  emulate -L zsh
  local default_action

  zstyle -s ":acceptline:${alcontext}" default_action default_action
  case ${default_action} in
    ((accept-line|))
      printf ".accept-line"
      ;;
    (*)
      printf ${default_action}
      ;;
  esac
}
function Accept-Line-HandleContext() {
  zle Accept-Line

  default_action=$(Accept-Line-getdefault)
  zstyle -T ":acceptline:${alcontext}" call_default \
    && zle ${default_action}
}
function accept-line() {
  setopt localoptions noksharrays
  local -ax cmdline
  local -x alcontext
  local buf com fname format msg default_action

  alcontext='default'
  buf="${BUFFER}"
  cmdline=(${(z)BUFFER})
  com="${cmdline[1]}"
  fname="_${com}"

  Accept-Line 'preprocess'

  zstyle -t ":acceptline:${alcontext}" rehash \
    && [[ -z ${commands[$com]} ]]           \
    && rehash

  if   [[ -n ${com}               ]] \
    && [[ -n ${reswords[(r)$com]} ]] \
    || [[ -n ${aliases[$com]}     ]] \
    || [[ -n ${functions[$com]}   ]] \
    || [[ -n ${builtins[$com]}    ]] \
    || [[ -n ${commands[$com]}    ]] ; then

    # there is something sensible to execute, just do it.
    alcontext='normal'
    Accept-Line-HandleContext

    return
  fi

  if   [[ -o correct              ]] \
    || [[ -o correctall           ]] \
    && [[ -n ${functions[$fname]} ]] ; then

    if [[ ${LASTWIDGET} == 'accept-line' ]] ; then
      alcontext='force'
      Accept-Line-HandleContext

      return
    fi

    if zstyle -t ":acceptline:${alcontext}" nocompwarn ; then
      alcontext='normal'
      Accept-Line-HandleContext
    else
    # prepare warning message for the user, configurable via zstyle.
      zstyle -s ":acceptline:${alcontext}" compwarnfmt msg

      if [[ -z ${msg} ]] ; then
        msg="%c will not execute and completion %f exists."
      fi

      zformat -f msg "${msg}" "c:${com}" "f:${fname}"

      zle -M -- "${msg}"
    fi
    return
  elif [[ -n ${buf//[$' \t\n']##/} ]] ; then
    alcontext='misc'
    Accept-Line-HandleContext

    return
  fi

  # If we got this far, the commandline only contains whitespace, or is empty.
  alcontext='empty'
  Accept-Line-HandleContext
}
zle -N accept-line
zle -N Accept-Line
zle -N Accept-Line-HandleContext

declare -A abk
setopt extendedglob
setopt interactivecomments
abk=(
  '...'  '../..'
  '....' '../../..'
  'BG'   '& exit'
  'C'    '| wc -l'
  'G'    '|& grep '
  'H'    '| head'
  'Hl'   ' --help |& less -r'
  'L'    '| less'
  'LL'   '|& less -r'
  'M'    '| most'
  'N'    '&>/dev/null'
  'R'    '| tr A-z N-za-m'
  'SL'   '| sort | less'
  'S'    '| sort -u'
  'T'    '| tail'
  'V'    '|& vim -'
  'co'   './configure && make && sudo make install'
  'syu'  'yaourt -Syua'
  'ss'   'yaourt -Ss '
  'si'   'yaourt -Si '
  's'    'yaourt -S '
  'sc'   'yaourt -Sc'
  'qs'   'yaourt -Qs '
  'qi'   'yaourt -Qi '
  'qo'   'yaourt -Qo '
  'ql'   'yaourt -Ql '
  'qm'   'yaourt -Qm'
  'qet'  'yaourt -Qet'
  'qdt'  'yaourt -Qdt'
  'rncs' 'yaourt -Rncs '
)

zleiab() {
  emulate -L zsh
  setopt extendedglob
  local MATCH

  if (( NOABBREVIATION > 0 )) ; then
    LBUFFER="${LBUFFER},."
    return 0
  fi

  matched_chars='[.-|_a-zA-Z0-9]#'
  LBUFFER=${LBUFFER%%(#m)[.-|_a-zA-Z0-9]#}
  LBUFFER+=${abk[$MATCH]:-$MATCH}
}
zle -N zleiab && bindkey ",." zleiab

autoload -U zmv
autoload -U history-search-end

autoload -U url-quote-magic && zle -N self-insert url-quote-magic

alias run-help >&/dev/null && unalias run-help
for rh in run-help{,-git,-svk,-svn}; do
  autoload -U $rh
done; unset rh

autoload -U compinit && compinit
autoload -U zed

for mod in complist deltochar mathfunc ; do
  zmodload -i zsh/${mod} 2>/dev/null
done

zmodload -a  zsh/stat    zstat
zmodload -a  zsh/zpty    zpty
zmodload -ap zsh/mapfile mapfile

autoload -U insert-files && zle -N insert-files && bindkey "^xf" insert-files

bindkey ' '   magic-space
bindkey '\ei' menu-complete

autoload -U edit-command-line && zle -N edit-command-line \
    && bindkey '\ee' edit-command-line

if [[ -n ${(k)modules[zsh/complist]} ]] ; then
  bindkey -M menuselect '\e^M' accept-and-menu-complete
  bindkey -M menuselect "+" accept-and-menu-complete
  bindkey -M menuselect "^[[2~" accept-and-menu-complete
  bindkey -M menuselect '^o' accept-and-infer-next-history
fi

insert-datestamp() { LBUFFER+=${(%):-'%D{%Y-%m-%d}'}; }
zle -N insert-datestamp
bindkey '^ed' insert-datestamp

insert-last-typed-word() { zle insert-last-word -- 0 -1 };
zle -N insert-last-typed-word;
bindkey "\em" insert-last-typed-word

function grml-zsh-fg() {
  if (( ${#jobstates} )); then
    zle .push-input
    [[ -o hist_ignore_space ]] && BUFFER=' ' || BUFFER=''
    BUFFER="${BUFFER}fg"
    zle .accept-line
  else
    zle -M 'No background jobs. Doing nothing.'
  fi
}
zle -N grml-zsh-fg
bindkey '^z' grml-zsh-fg

function jump_after_first_word() {
  local words
  words=(${(z)BUFFER})
  if (( ${#words} <= 1 )) ; then
    CURSOR=${#BUFFER}
  else
    CURSOR=${#${words[1]}}
  fi
}
zle -N jump_after_first_word
bindkey '^x1' jump_after_first_word

zle -C hist-complete complete-word _generic
zstyle ':completion:hist-complete:*' completer _history
bindkey "^x^x" hist-complete

ZSHDIR=$HOME/.zsh
HISTFILE=$HOME/.zsh_history
HISTSIZE=5000
SAVEHIST=10000

DIRSTACKSIZE=${DIRSTACKSIZE:-20}
DIRSTACKFILE=${DIRSTACKFILE:-${HOME}/.zdirs}
if [[ -f ${DIRSTACKFILE} ]] && [[ ${#dirstack[*]} -eq 0 ]] ; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi

chpwd() {
  local -ax my_stack
  my_stack=( ${PWD} ${dirstack} )
  builtin print -l ${(u)my_stack} >! ${DIRSTACKFILE}
}

function chpwd_profiles() {
  local profile context
  local -i reexecute

  context=":chpwd:profiles:$PWD"
  zstyle -s "$context" profile profile || profile='default'
  zstyle -T "$context" re-execute && reexecute=1 || reexecute=0
  if (( ${+parameters[CHPWD_PROFILE]} == 0 )); then
    typeset -g CHPWD_PROFILE
    local CHPWD_PROFILES_INIT=1
    (( ${+functions[chpwd_profiles_init]} )) && chpwd_profiles_init
  elif [[ $profile != $CHPWD_PROFILE ]]; then
    (( ${+functions[chpwd_leave_profile_$CHPWD_PROFILE]} )) \
      && chpwd_leave_profile_${CHPWD_PROFILE}
  fi
  if (( reexecute )) || [[ $profile != $CHPWD_PROFILE ]]; then
    (( ${+functions[chpwd_profile_$profile]} )) && chpwd_profile_${profile}
  fi
  CHPWD_PROFILE="${profile}"
  return 0
}

chpwd_functions=( ${chpwd_functions} chpwd_profiles )

if autoload -U vcs_info; then
  zstyle ':vcs_info:*' max-exports 2
  if [[ -o restricted ]]; then
    zstyle ':vcs_info:*' enable NONE
  fi
fi

#setopt transient_rprompt

PS2='\`%_> '
PS3='?# '
PS4='+%N:%i:%_> '
Z_RPROMPT_NORM="%(?.-- ins --.%{$Z_C_ERR%}-- %?%1v --%{$Z_C_END%})"
Z_PROMPT_I1="%{$Z_C_BG$Z_C_USR%}%n@%m:%{$Z_C_PWD%}%25<...<%~%<<"

# Miscelaneus info like git.
function prompt_misc () {
  local tbranch tcolor tstatus ttmp ttl ttr
  if [[ -n $(git branch 2> /dev/null) ]]; then
    tbranch=$(git branch)
    tbranch=${tbranch:2}
    tstatus=""
    ttmp=$(git status)
    if [[ -n $(echo $ttmp | grep 'Untracked') ]]; then
      tstatus+="+"
    fi
    if [[ -n $(echo $ttmp | grep 'nothing to commit') ]]; then
      tcolor=$Z_C_GIT
    else
      tcolor=$Z_C_ERR
      tstatus+="*"
    fi
    ttl=$(git rev-list master | wc -l)
    ttr=$(git rev-list origin/master | wc -l)
    if [[ $ttl > $ttr ]]; then
      tstatus+=" u"
    elif [[ $ttl < $ttr ]]; then
      tstatus+=" d"
    fi
    print "%{$tcolor%}<$tbranch$tstatus>"
  fi
}

function prompt_end () {
  local tcolor tsym
  if [[ "$1" == "c" ]]; then
    tfinal="${Z_C_MSG}"
    tsym=":"
  else # $1 == n
    tfinal="%(?.${Z_C_NT}.${Z_C_ERR})"
    tsym="%(?.%#.!)"
  fi
  print "%{$Z_C_DRK$tfinal%} $tsym %{$Z_C_END%} "
}

function ESC_print () {
  info_print $'\ek' $'\e\\' "$@"
}

function set_title () {
  info_print  $'\e]0;' $'\a' "$@"
}

function info_print () {
  local esc_begin esc_end
  esc_begin="$1"
  esc_end="$2"
  shift 2
  printf '%s' ${esc_begin}
  printf '%s' "$*"
  printf '%s' "${esc_end}"
}

zle-keymap-select() {
  if [[ $KEYMAP = vicmd ]]; then
    RPROMPT="%{$Z_C_MSG%}-- cmd --%{$Z_C_END%}"
    PROMPT="$Z_PROMPT_I1$(prompt_misc)$(prompt_end c)"
  else
    RPROMPT=$Z_RPROMPT_NORM
    PROMPT="$Z_PROMPT_I1$(prompt_misc)$(prompt_end n)"
  fi
  () { return $__prompt_status }
  zle reset-prompt
}

zle-line-init() {
  typeset -g __prompt_status="$?"
}

zle -N zle-keymap-select
zle -N zle-line-init

precmd () {
  (( ${+functions[vcs_info]} )) && vcs_info
  RPROMPT=$Z_RPROMPT_NORM
  PROMPT="$Z_PROMPT_I1$(prompt_misc)$(prompt_end n)"
  case $TERM in
    (xterm*|rxvt*)
      set_title ${(%):-"%n@%m %~"}
      ;;
  esac
}

preexec () {
  if [[ -n "$HOSTNAME" ]] && [[ "$HOSTNAME" != $(hostname) ]] ; then
    NAME="@$HOSTNAME"
  fi
  case $TERM in
    (xterm*|rxvt*)
      set_title "${(%):-"%n@%m"}" "$1"
      ;;
  esac
}

export COLORTERM="yes"
alias grep='grep --color=auto '
alias ls='ls -b -CF --color=auto --group-directories-first '
alias la='ls -la '
alias ll='ls -l '
alias lh='ls -hAl '
alias l='ls -lF '
alias mdstat='cat /proc/mdstat'
alias ...='cd ../../'
alias da='du -sch'
alias j='jobs -l'
alias dir="ls -lSrah"
alias lad='ls -d .*(/)'
alias lsa='ls -a .*(.)'
alias lss='ls -l *(s,S,t)'
alias lsl='ls -l *(@)'
alias lsx='ls -l *(*)'
alias lsw='ls -ld *(R,W,X.^ND/)'
alias lsbig="ls -flh *(.OL[1,10])"
alias lsd='ls -d *(/)'
alias lse='ls -d *(/^F)'
alias lsnew="ls -rtlh *(D.om[1,10])"
alias lsold="ls -rtlh *(D.Om[1,10])"
alias lssmall="ls -Srl *(.oL[1,10])"
alias lsnewdir="ls -rthdl *(/om[1,10]) .*(D/om[1,10])"
alias lsolddir="ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])"
alias rmcdir='cd ..; rmdir $OLDPWD || cd $OLDPWD'

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit -s

zstyle ':completion:*:approximate:'    max-errors \
    'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:correct:*'       insert-unambiguous true
zstyle ':completion:*:corrections'     format \
    "%{$Z_C_ERR%}%d, errors: %e%{$Z_C_END%}"
zstyle ':completion:*:correct:*'       original true
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions'    format "%{$Z_C_MSG%}%d%{$Z_C_END%}"
zstyle ':completion:*:expand:*'        tag-order all-expansions
zstyle ':completion:*:history-words'   list false
zstyle ':completion:*:history-words'   menu yes
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes
zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:matches'         group 'yes'
zstyle ':completion:*'                 group-name ''
zstyle ':completion:*'                 menu select=5
zstyle ':completion:*:messages'        format "%{$Z_C_OPT%}%d%{$Z_C_END%}"
zstyle ':completion:*:options'         auto-description \
    "%{$Z_C_PAR%}%d%{$Z_C_END%}"
zstyle ':completion:*:options'         description 'yes'
zstyle ':completion:*:processes'       command 'ps -au$USER'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*'                 verbose true
zstyle ':completion:*:-command-:*:'    verbose false
zstyle ':completion:*:warnings'        format \
    "%{$Z_C_ERR%}No matches:%{$Z_C_END%} %d"
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:'          prompt 'correct to: %e'
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
zstyle ':completion:*:processes-names' command \
    'ps c -u ${USER} -o command | uniq'
zstyle ':completion:*:manuals'         separate-sections true
zstyle ':completion:*:manuals.*'       insert-sections   true
zstyle ':completion:*:man:*'           menu yes select
zstyle ':completion:*'                 special-dirs ..

# run rehash on completion so new installed program are found automatically:
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1
}

setopt correct
zstyle -e ':completion:*' completer '
  if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
    _last_try="$HISTNO$BUFFER$CURSOR"
    reply=(_complete _match _ignored _prefix _files)
  else
    if [[ $words[1] == (rm|mv) ]] ; then
      reply=(_complete _files)
    else
      reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
    fi
  fi'

[[ -d $ZSHDIR/cache ]] && zstyle ':completion:*' use-cache yes && \
    zstyle ':completion::complete:*' cache-path $ZSHDIR/cache/

nt() {
  if [[ -n $1 ]] ; then
    local NTREF=${~1}
  fi
  [[ $REPLY -nt $NTREF ]]
}

sll() {
  [[ -z "$1" ]] && printf 'Usage: %s <file(s)>\n' "$0" && return 1
  for file in "$@" ; do
    while [[ -h "$file" ]] ; do
      ls -l $file
      file=$(readlink "$file")
    done
  done
}

cl() {
  emulate -L zsh
  cd $1 && ls -a
}

cd() {
  if (( ${#argv} == 1 )) && [[ -f ${1} ]]; then
    [[ ! -e ${1:h} ]] && return 1
    print "Correcting ${1} to ${1:h}"
    builtin cd ${1:h}
  else
    builtin cd "$@"
  fi
}

mkcd() {
  if (( ARGC != 1 )); then
    printf 'usage: mkcd <new-directory>\n'
    return 1;
  fi
  if [[ ! -d "$1" ]]; then
    command mkdir -p "$1"
  else
    printf '`%s'\'' already exists: cd-ing.\n' "$1"
  fi
  builtin cd "$1"
}

cdt() {
  local t
  t=$(mktemp -d)
  echo "$t"
  builtin cd "$t"
}

inplaceMkDirs() {
  local PATHTOMKDIR
  if ((REGION_ACTIVE==1)); then
    local F=$MARK T=$CURSOR
    if [[ $F -gt $T ]]; then
      F=${CURSOR}
      T=${MARK}
    fi
    PATHTOMKDIR=${BUFFER[F+1,T]%%[[:space:]]##}
    PATHTOMKDIR=${PATHTOMKDIR##[[:space:]]##}
  else
    local bufwords iword
    bufwords=(${(z)LBUFFER})
    iword=${#bufwords}
    bufwords=(${(z)BUFFER})
    PATHTOMKDIR="${(Q)bufwords[iword]}"
  fi
  [[ -z "${PATHTOMKDIR}" ]] && return 1
  PATHTOMKDIR=${~PATHTOMKDIR}
  if [[ -e "${PATHTOMKDIR}" ]]; then
    zle -M " path already exists, doing nothing"
  else
    zle -M "$(mkdir -p -v "${PATHTOMKDIR}")"
    zle end-of-line
  fi
}
zle -N inplaceMkDirs && bindkey '^xM' inplaceMkDirs

accessed() {
  emulate -L zsh
  print -l -- *(a-${1:-1})
}

changed() {
  emulate -L zsh
  print -l -- *(c-${1:-1})
}

modified() {
  emulate -L zsh
  print -l -- *(m-${1:-1})
}

source ~/.zsh/plugins/zsh-syntax-highlight/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
if [[ $TERM == "xterm-256color" ]]; then
  ZSH_HIGHLIGHT_STYLES[default]='none'
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=9'
  ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=11'
  ZSH_HIGHLIGHT_STYLES[alias]='fg=10'
  ZSH_HIGHLIGHT_STYLES[builtin]='fg=10'
  ZSH_HIGHLIGHT_STYLES[function]='fg=10'
  ZSH_HIGHLIGHT_STYLES[command]='fg=10'
  ZSH_HIGHLIGHT_STYLES[precommand]='fg=10,underline'
  ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
  ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=10'
  ZSH_HIGHLIGHT_STYLES[path]='fg=12'
  ZSH_HIGHLIGHT_STYLES[globbing]='fg=12'
  ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=12'
  ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
  ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
  ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=14'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=14'
  ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=9'
  ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=14'
  ZSH_HIGHLIGHT_STYLES[assign]='none'

  ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=9,bold'
  ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=12'
  ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=10'
  ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=13'
  ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=11'
  ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=14'
  ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'
else
  ZSH_HIGHLIGHT_STYLES[default]='none'
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=black,bold'
  ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow,bold'
  ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
  ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[path]='fg=blue,bold'
  ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
  ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue,bold'
  ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
  ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
  ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=cyan,bold'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan,bold'
  ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=red,bold'
  ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan,bold'
  ZSH_HIGHLIGHT_STYLES[assign]='none'

  ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=black,bold'
  ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
  ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
  ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'
  ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=cyan,bold'
  ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'
fi
# TODO: define some pattern to highlight.

