#!/bin/bash
conda deactivate
conda deactivate
TEST=$(conda env list)
set -f
env_list=()
bold=$(tput bold)
normal=$(tput sgr0)
BLUE='\033[34m'
NC='\033[0m' # No Color
for i in $(echo $TEST | tr " " "\n")
do
    if [[ "$i" == *"/"* ]]; then
        declare -a array=($(echo $i | tr "/" " "))
        #echo ${array[${#array[@]}-1]}
        if [[ "${array[${#array[@]}-1]}" != *"anaconda"* ]]; then
            env_list+=(${array[${#array[@]}-1]})
        fi
    fi
  # process
done

menu_from_array ()
{
select item; do
# Check the selected menu item number
if [ 1 -le "$REPLY" ] && [ "$REPLY" -le $# ];

then
echo -e "The selected conda env is ${BLUE}${bold}$item${normal}${NC}"
echo -e "${BLUE}${bold}DONE !${normal}${NC}"
conda activate $item
break;
else
echo "Wrong selection: Select any number from 1-$#"
fi
done
}
echo -e "${BLUE}${bold}Which conda env do you like to activate ?${normal}${NC}"
menu_from_array "${env_list[@]}"