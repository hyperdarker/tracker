#!/bin/bash
MINUTES=180 # 3 hours expected
FILE="$HOME/.log/tracker"

if [[ "$1" == "log" ]]; then
    cat "$FILE"
    exit 0
fi

if [ $# -gt 0 ];then
    MINUTES=$1
    re='^[0-9.]+$'
    if ! [[ $MINUTES =~ $re ]] ; then
        echo "error: Not a number" >&2; exit 1
    fi
fi

elapsed=0
start=$(date +%s)
STATUS="RUNNING"

while true; do 
    #read  -r -p  "[Activa] [p] Pausar, [f] Finalizar: "  answer
    if [ $STATUS == "RUNNING" ]; then
        start=$(date +%s)
        read -p $'\e[32m[RUNNING]\e[0m ENTER to Pause. ';
        stop=$(date +%s)
        elapsed=$((elapsed + stop - start))
        STATUS="PAUSE"
    elif [ $STATUS == "PAUSE" ]; then
        echo   " Elapsed:" $(date -d@$elapsed -u +%H:%M:%S)
        echo -e "Expected:" $(date -d@$((MINUTES*60)) -u +%H:%M:%S)
        while true; do
            read -p $'\e[35m[PAUSED]\e[0m R to Resume or S to Stop. ' answer
            if [ -z $answer ]; then continue; fi
            if [ $answer == 'r' ] || [ $answer == 'R' ]; then
                STATUS="RUNNING"
                break
            elif [ $answer == 's' ] || [ $answer == 'S' ]; then
                if [ $elapsed -ge 120 ]; then
                    echo "Elapsed: ("$(date -d@$elapsed -u +%H:%M:%S)") at" $(date '+%H:%M %D')" ...SAVED!"
                    echo " "$(date -d@$elapsed -u +%H:%M:%S)" at" $(date '+%H:%M %D') >> $FILE
                else
                    echo "Don't Saved."
                fi
                exit 0
            fi
        done
    fi    
done