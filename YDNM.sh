#!/bin/bash

##############################################################
#
#       clean up log files on UNIX
#
#       copyright 2022 @ S3R43o3
#
##############################################################
#         THIS SCRIPT HAVE TO BE RUN AS ROOT OFC             #
##############################################################
# Colors
cRed=`tput setaf 1`
cBlue=`tput setaf 2`
cCyan=`tput setaf 6`
cYellow=`tput setaf 3`
cReset=`tput sgr0`
cBold=`tput bold`
cBlink=`tput blink`
BlinkC(){
    echo $cBlink$cRed$cBold$1$cReset
}
RedC(){
    echo $cRed$cBold$1$cReset
}
CyanC(){
    echo $cCyan$cBold$1$cReset
}
YellowC(){
    echo $cYellow$cBold$1$cReset
}
BlueC(){
    echo $cBlue$cBold$1$cReset
}
##############################################################
#Main

LOG_DIR=/var/log
ROOT_UID=0
LINES=50
E_XCD=86
E_NOTROOT=87


echo -ne ${cYellow}${cBold}"        __  _____________  __   ____________________   _________
        _ \/ /_  __ \_  / / /   ___  __ \_  __ \__  | / /__  __/
        __  /_  / / /  / / /    __  / / /  / / /_   |/ /__  /   
        _  / / /_/ // /_/ /     _  /_/ // /_/ /_  /|  / _  /    
        /_/  \____/ \____/      /_____/ \____/ /_/ |_/  /_/     
        _____   ___________       __   ______  ____________
        ___  | / /_  __ \_ |     / /   ___   |/  /__  ____/
        __   |/ /_  / / /_ | /| / /    __  /|_/ /__  __/   
        _  /|  / / /_/ /__ |/ |/ /     _  /  / / _  /___   
        /_/ |_/  \____/ ____/|__/      /_/  /_/  /_____/   
"

echo
if [ "$UID" -ne "$ROOT_UID" ]
then
    echo ${cRed}${cBold}"      ERROR! Must be root to run this script!"
    echo ${cRed}${cBold}${cBlink}"      Exit soon..."
    sleep 4
    clear
    exit $E_NOTROOT
fi

if [ -n "$1" ]
then
    lines=$1
else
    lines=$LINES
fi

#    E_WRONGARGS=85  # Non-numerical argument (bad argument format).
#
#    case "$1" in
#    ""      ) lines=50;;
#    *[!0-9]*) echo "Usage: `basename $0` lines-to-cleanup";
#     exit $E_WRONGARGS;;
#    *       ) lines=$1;;
#    esac
#


cd $LOG_DIR

if [ `pwd` != "$LOG_DIR" ]  # or   if [ "$PWD" != "$LOG_DIR" ]
                            # Not in /var/log?
then
  echo ${cRed}${cBold}"Can't change to $LOG_DIR."
  exit $E_XCD
fi  
# Far more efficient is:
#
# cd /var/log || {
#   echo "Cannot change to necessary directory." >&2
#   exit $E_XCD;
# }


echo ${cYellow}${cBold}"clearing logfiles..."


tail -n $lines messages > mesg.temp # Save last section of message log file.
mv mesg.temp messages               # Rename as log file





cat /dev/null > wtmp  #  ': > wtmp' and '> wtmp'  have the same effect.
echo ${cYellow}${cBold}"Success! Logfiles cleaned up!"
#  Note that there are other log files in /var/log not affected
#+ by this script.

exit 0 #  0 return value, exit indicates success + to the shell.
