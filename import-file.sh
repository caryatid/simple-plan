#!/bin/sh
TMP=$(mktemp -d)
trap 'rm -Rf $TMP' EXIT

# convert to directory nodes; file leaves.


seed=$(dd if=/dev/urandom bs=255 count=1 2>/dev/null | tr \\0 \ )
count=0
_gen_hash () {
    echo -n $count$seed | sha1sum | cut -d' ' -f1 | tr -d '\n'
    count=$(( $count + 1 ))
}

_make_leaf () {
    test -z "$1" && exit 1
    test -e "$1" || touch "$1"
}

_no_empty () {
    sed '/^[[:space:]]*$/d'
}

_pop () {
    val=$(<$TMP/stack _no_empty | tail -n1)
    test -z "$val" && return 1
    <$TMP/stack _no_empty | head -n-1  >$TMP/_stack
    mv $TMP/_stack $TMP/stack
}

_parse_note_file () {
    bdir="__${1}__"
    mkdir -p "$bdir"; cd "$bdir"
    truncate -s 0 $TMP/stack; pwd >$TMP/stack
    local pname=''
    local pdepth=0
    local h; local depth; local name; local dif;
    while read entry
    do
        depth=$(echo $entry | cut -d' ' -f1)
        name=$(echo $entry | cut -d' ' -f2-)
        dif=$(( $depth - $pdepth ))
        case $dif in
        0)
            _make_leaf "$name"
            pname="$name"
            ;;
        1)
            if test -f "$pname"
            then 
                h=$(_gen_hash | cut -c-7)
                mv "$pname" "${pname}_${h}"
                mkdir -p "$pname"; mv "${pname}_${h}" "${pname}"
            fi
            cd "$pname"
            echo "$pname" >>$TMP/stack
            _make_leaf "$name"
            pname="$name"
            pdepth=$depth
            ;;
        *)        
            for _ in $(seq $(( $dif * -1 ))); do _pop; cd ..; done
            _make_leaf "$name"
            pdepth=$depth
            pname="$name"
            ;;
        esac
    done
}

test -f "$1" || exit 1
FNAME="$1"
<"$FNAME" _no_empty \
    | awk '{ match($0, /^[[:space:]]*/); print RLENGTH/4, $0 }' \
    | _parse_note_file "$FNAME"

    
