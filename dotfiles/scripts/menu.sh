#!/bin/sh

printenv PATH | xargs -d':' -I{} -r -- \
                      find -L {}  -mindepth 1 -maxdepth 1 \
                      -type f -executable -printf '%P\n' 2>/dev/null \
    | grep -v -- '-wrapped$' | sort -u \
    | fzf --border --reverse | xargs setsid -f
