#!/bin/bash

type() {
    s=$@
    for ((i=0; i<${#s} ; i++)) ; do 
        echo -n "${s:i:1}"
        sleep 0.05
    done
    echo 
}

pause() { sleep 1; }
exe() { pause; type "\$ $@" ; pause; "$@" ; pause; }

demo_start() {
    clear
    sleep 0.1
}

demo_end() {
    read wait
}
