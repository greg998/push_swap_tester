ROOT=..
CHECKER=./checker_linux

BLACK="\033[1;30m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
GREEN="\033[1;32m"
CYAN="\033[1;35m"
PURPLE="\033[1;36m"
WHITE="\033[1;37m"
BLUE="\033[34;1m"
NOCOLOR="\e[0m"

tput civis
trap "tput cvvis && exit" SIGINT

TOTAL=0
MIN=1000000000
MAX=0
NB_OK=0
NB_KO=0
NB_ERROR=0
mkdir test_files 2>/dev/null
gcc srcs/random.c -O3

for ((i = 1; i <= $2; i++)); do
    printf "\r$BLUE WAITING FOR tests $YELLOW $i $BLUE / $2"
    
    ./a.out $1 $3 > test_files/$i
    IN=$(cat test_files/$i)
    $ROOT/push_swap $IN &> test_files/o$i

    OUT=$(cat test_files/o$i)
    CHECKER_OUT=$(< test_files/o$i $CHECKER $IN 2>/dev/null)

    if [[ $CHECKER_OUT == "OK" ]]
    then
        printf "$GREEN OK"
        OK+="$i "
        NB_OK=$(($NB_OK + 1))
    elif [[ $CHECKER_OUT == "KO" ]]
    then
        printf "$RED KO"
        KO+="$i "
        NB_KO=$(($NB_KO + 1))
    else
        printf "$RED ER"
        ERROR+="$i "
        NB_ERROR=$(($NB_ERROR + 1))
    fi
    NB_INSTR=$(echo "$OUT" | wc -l)
    let TOTAL+=$NB_INSTR
    MIN=$(($NB_INSTR < $MIN ? $NB_INSTR : $MIN))
    MAX=$(($NB_INSTR > $MAX ? $NB_INSTR : $MAX))
    printf " %.$(($i % 6))s  \b\b\b\b\b" "....."
done
let AVG=$TOTAL/$2
printf "\n$GREEN"

printf "OK $NB_OK / $2\n"
printf "${RED}KO $NB_KO / $2"
if [ $NB_KO -gt 0 ]
then
    printf " at $KO"
fi
printf "\nERROR $NB_ERROR / $2"
if [ $NB_ERROR -gt 0 ]
then
    printf " at $ERROR"
fi
printf "\n\n${BLUE}Min instructions: $MIN\n"
printf "Max instructions: $MAX\n"
printf "Avg instructions: $AVG\n"
printf "$NOCOLOR"
tput cvvis
