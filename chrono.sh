#!/bin/bash
FILE="$HOME/.log/chrono"

#flag status = running/paused/finished
elapsed=0
start=$(date +%s)
status="RUNNING"

if [[ "$1" == "log" ]]
then
    echo
    tail -6 "$FILE"
    exit 0
fi

echo -e "Sesion Iniciada: $(date '+%X')\n"

while [ $status != "FINISHED" ];do
    # running
    if [ $status == "PAUSED" ];then
        echo -e "\n[Pausada] Presiona Enter para reanudar la sesion."
        read;
        start=$(date +%s)
    fi
    answer="nil"
    while [ $answer == "nil" ];do 
    read  -r -p  "[Activa] [p] Pausar, [f] Finalizar: "  answer
    if [ -z $answer ]; then answer="nil";fi
        case $answer in 
        [p]* )  
            status="PAUSED"
            stop=$(date +%s)
            elapsed=$((elapsed + stop - start))
            break
            ;;   
        [f]* )  
            status="FINISHED" 
            stop=$(date +%s)
            elapsed=$((elapsed + stop - start))
            MINUTES=$((elapsed/60)) 
            SECONDS=$((elapsed%60))
            printf "Time: %02d:%02d\n" $MINUTES $SECONDS
            printf "%02d:%02d %(%F)T\n" $MINUTES $SECONDS -1 >> $FILE
            break;;
        esac
    done
done
