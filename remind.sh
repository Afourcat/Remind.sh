#!/usr/bin/env bash


usage() { echo "Usage: $0 [-s secondes] [-m minutes] [-h hours] [-t title] -o message" 1>&2; exit 1; }

while getopts ":s:h:m:o:t:" opt; do
    case "${opt}" in
        s)
            s=${OPTARG}
            ;;
        h)
            h=${OPTARG}
            ;;
        m)
            m=${OPTARG}
            ;;
        o)
            o=${OPTARG}
            ;;
        t)
            t=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [[ -z "${o}" ]] || [[ -z "${s}"  &&  -z "${h}"  &&  -z "${m}" ]]; then
    usage
    exit 1
fi

if [ -z "${h}" ]; then
    h=0
fi

if [ -z "${s}" ]; then
    s=0
fi

if [ -z "${m}" ]; then
    m=0
fi

(( time = ( h*60*60 ) + ( m*60 ) + s ))

sleep_and_notify() {
    sleep $time ; notify-send $t "$o"
}

sleep_and_notify &

exit 0
