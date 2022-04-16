#!/bin/bash
FILE="$HOME/.log/tracker"
if [[ "$1" == "log" ]]
then
    tail -6 "$FILE"
    exit 0
fi

TYPE=""
MINUTES=0

config() {
    TYPE=$1
    MINUTES=$2
}

if [ $# -eq 0 ];then
    config "D" 15

elif [ "$1" == "a" ];then
    config "A" 30

elif [ "$1" == "b" ];then
    config "B" 20

else
    config "X" $1
    re='^[0-9]+$'
    if ! [[ $MINUTES =~ $re ]] ; then
        echo "error: Not a number" >&2; exit 1
    fi
fi

START_TIME=$(date '+%X %D')
echo -e "[$MINUTES min]  $TYPE"
sleep $((MINUTES*60))
#sleep $((MINUTES*1)) # for testing
STOP_TIME=$(date '+%X %D')
echo -e "\nFrom\t" $START_TIME "\nTo\t" $STOP_TIME
echo -e "[$MINUTES min]\t$TYPE\t" $START_TIME ">" $STOP_TIME >> $FILE
notify-send -u critical "SESION FINALIZADA!"