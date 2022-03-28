#!/bin/bash

#############################################
#
#           auto Backup-script
#
#        copyright 2022 @ S3R43o3
#
#############################################
# Colors
cRed=`tput setaf 1`
cBlue=`tput setaf 2`
cCyan=`tput setaf 6`
cYellow=`tput setaf 3`
cReset=`tput sgr0`
cBold=`tput bold`
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

#############################################
# Change this for your needs 
# dir/files to backup
backup_files=/home
# backup destination location
destination=/home/B4CKP4CK-Backup
#############################################


day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

echo "$(CyanC "_____________________________________________________________________")"
echo -ne $cCyan$cBold'
__________                  __    __________                  __    
\______   \_____     ____  |  | __\______   \_____     ____  |  | __
 |    |  _/\__  \  _/ ___\ |  |/ / |     ___/\__  \  _/ ___\ |  |/ /
 |    |   \ / __ \_\  \___ |    <  |    |     / __ \_\  \___ |    < 
 |______  /(____  / \___  >|__|_ \ |____|    (____  / \___  >|__|_ \
        \/      \/      \/      \/                \/      \/      \/
                                                             
'$cReset
echo "$(CyanC "_____________________________________________________________________")"
echo
echo "$(CyanC "Backup startet at: ")"
echo ${cBlue}${cBold}
date
if [[ ! -e $destination ]]; then
    echo
    echo "$(RedC "Backup-Directory dosent exists!")"
    echo "$(YellowC "create Backup-Directory...")"
    mkdir $destination
elif [[ ! -d $destination ]]; then
    echo
    echo "$destination already exists but is not a directory" 1>&2
fi
echo    
echo "$(YellowC "Backing up") \"${backup_files}\""
echo "$(YellowC "to") \"${destination}/${archive_file}\""
echo
tar czf $destination/$archive_file $backup_files
echo "$(CyanC "Backup finished at: ")"
echo ${cBlue}${cBold}
date
echo "$(CyanC "_____________________________________________________________________")"

