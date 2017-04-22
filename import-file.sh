#!/bin/sh
TMP=$(mktemp -d)
trap 'rm -Rf $TMP' EXIT

# convert to directory nodes; file leaves.

test -f "$1" || exit 1

_make_leaf () {
    test -z "$1" && exit 1
    test ! -e "$1" || touch "$1"
}

_parse_note_file () {
    truncate -s 0 $TMP/stack; pwd >$TMP/stack
    local pname=''
    local pdepth=0
    while read
    do
        local depth=$(echo $REPLY | cut -d' ' -f1)
        local name=$(echo $REPLY | cut -d' ' -f2-)
        case $(( $depth - $pdepth )) in
        0)
            _make_leaf "$name"
            pname="$name"
            ;;
        1)
            test -f "$pname" && mv "$pname" "${pname}_"
            mkdir "$pname"; cd "$pname"
            echo "$pname" >>$TMP/stack
            _make_leaf "$name"
            ;;
        *)        
            echo breakfast is more important than implementation
            ;;
        esac
    done
}
                
            
                

<"$1" sed '/^[[:space:]]*$/d' \
    | awk '{ match($0, /^[[:space:]]*/); print RLENGTH/4, $0 }' \
    | _parse_note_file

    
