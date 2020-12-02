#!/usr/bin/zsh
# Special chars between https://en.wikipedia.org/wiki/Code_page_437

ZSHDIR=$HOME/.config/zsh
HISTFILE=$ZSHDIR/histfile
HISTSIZE=1000
SAVEHIST=1000

source $ZSHDIR/paths
source $ZSHDIR/functions
source $ZSHDIR/aliases

export EDITOR="nvim"
export PAGER="less"
export SHELL="/usr/bin/zsh"
export BROWSER="google-chrome-stable"
export COLORTERM="yes"

# Workaround for vte overriding $TERM
#if [[ ${TERM} == "xterm" ]]; then
#    export TERM="xterm-256color"
#fi

if [ "$TERM" != "xterm-256color" ]; then
    #echo -en "\e]P00C1E20"
    echo -en "\e]P0000000"
    echo -en "\e]P1B7141E"
    echo -en "\e]P2457B23"
    echo -en "\e]P3F5971D"
    echo -en "\e]P4134EB2"
    echo -en "\e]P5550087"
    echo -en "\e]P60E707C"
    echo -en "\e]P7EEEEEE"
    echo -en "\e]P8424242"
    echo -en "\e]P9E83A3F"
    echo -en "\e]PA7ABA39"
    echo -en "\e]PBFEE92E"
    echo -en "\e]PC53A4F3"
    echo -en "\e]PDA94DBB"
    echo -en "\e]PE26BAD1"
    echo -en "\e]PFD8D8D8"
    #  clear #for background artifacting
fi

eval $(dircolors $ZSHDIR/16.dircolors)
# the ^[ is "entered" by typing Ctrl+v and Ctrl+[
if (( EUID == 0 )); then
    bgp="[41m"
    fgu="[91m"
else
    bgp="[42m"
    fgu="[92m"
fi
bg1="[41m"
bg3="[43m"
bg6="[46m"
fg2="[32m"
fg3="[33m"
fg6="[36m"
fg9="[91m"
fga="[92m"
fgb="[93m"
fgc="[94m"
fgd="[95m"
fge="[96m"
fgf="[97m"
vend="[0m"

setopt append_history
setopt share_history
setopt histignorealldups
setopt histignoredups
setopt histignorespace
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

#export GREP_COLORS
export LS_COLORS
export LESS_TERMCAP_mb=$fgb
export LESS_TERMCAP_md=$fgd
export LESS_TERMCAP_me=$vend
export LESS_TERMCAP_se=$vend
export LESS_TERMCAP_so=$fg6
export LESS_TERMCAP_ue=$vend
export LESS_TERMCAP_us=$fga

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

bindkey "\eOH" beginning-of-somewhere  # home
bindkey "[H" beginning-of-somewhere  # home
bindkey "\eOF" end-of-somewhere        # end
bindkey "[F" end-of-somewhere        # end

bindkey "\e[A"  up-line-or-search       # cursor up
bindkey "\e[B"  down-line-or-search     # <ESC>-

## use Ctrl <- and Ctrl -> for jumping to word-beginnings on the CL
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
## the same for alt-left-arrow and alt-right-arrow
bindkey "[1;3C" forward-word
bindkey "[1;3D" backward-word

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end  history-search-end
bindkey "^xp"   history-beginning-search-backward-end
bindkey "^xP"   history-beginning-search-forward-end
bindkey "\e[5~" history-beginning-search-backward-end # PageUp
bindkey "\e[6~" history-beginning-search-forward-end  # PageDown

autoload -U insert-unicode-char
zle -N insert-unicode-char
bindkey "^xi" insert-unicode-char

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
bindkey "^xA" grml_toggle_abbrev

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

bindkey "\ev" slash-backward-kill-word
bindkey "\e^h" slash-backward-kill-word
bindkey "\e^?" slash-backward-kill-word

bindkey "^r" history-incremental-pattern-search-backward
bindkey "^s" history-incremental-pattern-search-forward

zstyle ":acceptline:*" rehash true
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
        [[ ${sub} == "accept-line" ]] && sub=".accept-line"
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

    alcontext="default"
    buf="${BUFFER}"
    cmdline=(${(z)BUFFER})
    com="${cmdline[1]}"
    fname="_${com}"

    Accept-Line "preprocess"

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
        alcontext="normal"
        Accept-Line-HandleContext

        return
    fi

    if   [[ -o correct              ]] \
      || [[ -o correctall           ]] \
      && [[ -n ${functions[$fname]} ]] ; then

        if [[ ${LASTWIDGET} == "accept-line" ]] ; then
            alcontext="force"
            Accept-Line-HandleContext

            return
        fi

        if zstyle -t ":acceptline:${alcontext}" nocompwarn ; then
            alcontext="normal"
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
        alcontext="misc"
        Accept-Line-HandleContext

        return
    fi

    # If we got this far, the commandline only contains whitespace, or is empty.
    alcontext="empty"
    Accept-Line-HandleContext
}
zle -N accept-line
zle -N Accept-Line
zle -N Accept-Line-HandleContext

declare -A abk
setopt extendedglob
setopt interactivecomments
abk=(
"..."  "../.."
"...." "../../.."
"BG"   "& exit"
"C"    "| wc -l"
"G"    "|& grep "
"H"    "| head"
"Hl"   " --help |& less -r"
"L"    "| less"
"LL"   "|& less -r"
"M"    "| most"
"N"    "&>/dev/null"
"R"    "| tr A-z N-za-m"
"SL"   "| sort | less"
"S"    "| sort -u"
"T"    "| tail"
"V"    "|& nvim -"
"co"   "./configure && make && sudo make install"
"syu"  "yay -Syu"
"ss"   "yay -Ss "
"si"   "yay -Si "
"s"    "yay -S "
"sc"   "yay -Sc"
"qs"   "yay -Qs "
"qi"   "yay -Qi "
"qo"   "yay -Qo "
"ql"   "yay -Ql "
"qm"   "yay -Qm"
"qet"  "yay -Qet"
"qdt"  "yay -Qdt"
"rncs" "yay -Rncs "
)

zleiab() {
    emulate -L zsh
    setopt extendedglob
    local MATCH

    if (( NOABBREVIATION > 0 )) ; then
#        LBUFFER="${LBUFFER},."
        LBUFFER="${LBUFFER} "
        return 0
    fi

    matched_chars="[.-|_a-zA-Z0-9]#"
    LBUFFER=${LBUFFER%%(#m)[.-|_a-zA-Z0-9]#}
    LBUFFER+=${abk[$MATCH]:-$MATCH}
    _zsh_highlight # workaround to highlight after autocompleting
}
zle -N zleiab && bindkey "^@" zleiab
#zle -N zleiab && bindkey ",." zleiab

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

bindkey " "   magic-space
bindkey "\ei" menu-complete

autoload -U edit-command-line && zle -N edit-command-line \
    && bindkey "\ee" edit-command-line

if [[ -n ${(k)modules[zsh/complist]} ]] ; then
    bindkey -M menuselect "\e^M" accept-and-menu-complete
    bindkey -M menuselect "+" accept-and-menu-complete
    bindkey -M menuselect "^[[2~" accept-and-menu-complete
    bindkey -M menuselect "^o" accept-and-infer-next-history
fi

insert-datestamp() { LBUFFER+=${(%):-"%D{%Y-%m-%d}"}; }
zle -N insert-datestamp
bindkey "^ed" insert-datestamp

insert-last-typed-word() { zle insert-last-word -- 0 -1 };
zle -N insert-last-typed-word;
bindkey "\em" insert-last-typed-word

function grml-zsh-fg() {
    if (( ${#jobstates} )); then
        zle .push-input
        [[ -o hist_ignore_space ]] && BUFFER=" " || BUFFER=""
        BUFFER="${BUFFER}fg"
        zle .accept-line
    else
        zle -M "No background jobs. Doing nothing."
    fi
}
zle -N grml-zsh-fg
bindkey "^z" grml-zsh-fg

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
bindkey "^x1" jump_after_first_word

zle -C hist-complete complete-word _generic
zstyle ":completion:hist-complete:*" completer _history
bindkey "^x^x" hist-complete

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
    zstyle -s "$context" profile profile || profile="default"
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
    zstyle ":vcs_info:*" max-exports 2
    if [[ -o restricted ]]; then
        zstyle ":vcs_info:*" enable NONE
    fi
fi

#setopt transient_rprompt

PS2="\`%_» "
PS3="?# "
PS4="+%N:%i:%_» "

function prompt_misc() {
    local tmp ttmp ttl ttr
    tmp=$(git branch 2> /dev/null)
    if [[ -n $tmp ]]; then
        tmp=${tmp:2}
        ttmp=$(git status)
        if [[ -n $(echo $ttmp | grep "Untracked") ]]; then
            tmp+="+"
        elif [[ -n $(echo $ttmp | grep "Changes") ]]; then
            tmp+="*"
        fi
        ttl=$(git rev-list master | wc -l)
        ttr=$(git rev-list origin/master | wc -l)
        if [[ $ttl > $ttr ]]; then
            tmp+="↑"
        elif [[ $ttl < $ttr ]]; then
            tmp+="↓"
        fi
        print "%{$fge%} $tmp"
    fi
}
function prompt_left() {
    if [[ $KEYMAP = vicmd ]]; then
        print "%{$bg3%} : %{$vend%} "
    else
        print "%{$bgp%} %(?.%{$fgf%}%#.%{$fgb%}ε) %{$vend%} "
    fi
}
function prompt_right() { 
    local t
    if [[ -n ${VIRTUAL_ENV} ]]; then
        t="${VIRTUAL_ENV:t}"
    else
        t="∞"
    fi
    t="%(?.%{$fg2%}$t.%{$fg9%}%?) "
    print "$t%{$fgu%}%n@%m%{$vend%}:%{$fgc%}%20<«<%~%<<$(prompt_misc)%{$vend%}"
}

function info_print() {
    local esc_begin esc_end
    esc_begin="$1"
    esc_end="$2"
    shift 2
    printf "%s" ${esc_begin}
    printf "%s" "$*"
    printf "%s" "${esc_end}"
}

function ESC_print() {
    info_print $'\ek' $'\e\\' "$@"
}

function set_title() {
    case $TERM in
    (xterm*|rxvt*)
        info_print  $'\e]0;' $'\a' "$@"
        ;;
    esac
}

zle-keymap-select() {
    RPROMPT="$(prompt_right)"
    PROMPT="$(prompt_left)"
    () { return $__prompt_status }
    zle reset-prompt
}

zle-line-init() {
    typeset -g __prompt_status="$?"
}

zle -N zle-keymap-select
zle -N zle-line-init

precmd() {
    (( ${+functions[vcs_info]} )) && vcs_info
    #ZLE_RPROMPT_INDENT=0 # NO USAR, buggy quita espacio al inicio
    RPROMPT="$(prompt_right)"
    PROMPT="$(prompt_left)"
    set_title ${(%):-"%n@%m %~"}
}

preexec() {
#    if [[ -n "$HOSTNAME" ]] && [[ "$HOSTNAME" != $(hostname) ]] ; then
#        NAME="@$HOSTNAME"
#    fi
    set_title "${(%):-"%n@%m"}" "$1"
}

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit -s

zstyle ":completion:*:approximate:"    max-errors \
    "reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )"
zstyle ":completion:*:correct:*"       insert-unambiguous true
zstyle ":completion:*:corrections"     format "%{$fg9%}%d, errors: %e%{$vend%}"
zstyle ":completion:*:correct:*"       original true
zstyle ":completion:*:default"         list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*:descriptions"    format "%{$fgb%}%d%{$vend%}"
zstyle ":completion:*:expand:*"        tag-order all-expansions
zstyle ":completion:*:history-words"   list false
zstyle ":completion:*:history-words"   menu yes
zstyle ":completion:*:history-words"   remove-all-dups yes
zstyle ":completion:*:history-words"   stop yes
zstyle ":completion:*"                 matcher-list "m:{a-z}={A-Z}"
zstyle ":completion:*:matches"         group "yes"
zstyle ":completion:*"                 group-name ""
zstyle ":completion:*"                 menu select=5
zstyle ":completion:*:messages"        format "%{$fgd%}%d%{$vend%}"
zstyle ":completion:*:options"         auto-description "%{$fga%}%d%{$vend%}"
zstyle ":completion:*:options"         description "yes"
zstyle ":completion:*:processes"       command "ps -au$USER"
zstyle ":completion:*:*:-subscript-:*" tag-order indexes parameters
zstyle ":completion:*"                 verbose true
zstyle ":completion:*:-command-:*:"    verbose false
zstyle ":completion:*:warnings"        format "%{$fg9%}No matches:%{$vend%} %d"
zstyle ":completion:*:*:zcompile:*"    ignored-patterns "(*~|*.zwc)"
zstyle ":completion:correct:"          prompt "correct to: %e"
zstyle ":completion::(^approximate*):*:functions" ignored-patterns "_*"
zstyle ":completion:*:processes-names" command \
    "ps c -u ${USER} -o command | uniq"
zstyle ":completion:*:manuals"         separate-sections true
zstyle ":completion:*:manuals.*"       insert-sections   true
zstyle ":completion:*:man:*"           menu yes select
zstyle ":completion:*"                 special-dirs ..

# run rehash on completion so new installed program are found automatically:
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1
}

setopt correct
zstyle -e ":completion:*" completer '
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

[[ -d $ZSHDIR/cache ]] && zstyle ":completion:*" use-cache yes && \
    zstyle ":completion::complete:*" cache-path $ZSHDIR/cache/

source $ZSHDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

