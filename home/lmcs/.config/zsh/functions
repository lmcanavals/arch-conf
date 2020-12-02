#!/usr/bin/zsh

nt() {
    if [[ -n $1 ]] ; then
        local NTREF=${~1}
    fi
    [[ $REPLY -nt $NTREF ]]
}

sll() {
    [[ -z "$1" ]] && printf "Usage: %s <file(s)>\n" "$0" && return 1
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
        printf "usage: mkcd <new-directory>\n"
        return 1;
    fi
    if [[ ! -d "$1" ]]; then
        command mkdir -p "$1"
    else
        printf "'%s' already exists: cd-ing.\n" "$1"
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
zle -N inplaceMkDirs && bindkey "^xM" inplaceMkDirs

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

