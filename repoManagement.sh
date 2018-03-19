#!/bin/bash

#Script automation repository and groups management

clear

echo "#################################################################"
echo "#                                                               #"
echo "#           Welcome in the automated repo management            #"
echo "#                                                               #"
echo "#################################################################"
echo "#"
echo "Press 1 if you want to create a new project"
echo "#"
echo "Press 2 if you want to get the list of projects"
echo "#"
echo "Press 3 if you want to delete a project"
echo "#"
echo "Press 4 if you want to get the users for a project"
echo "#"
echo "Press 5 if you want to create a bunch of project from a text file"
echo "#"
echo "Press 6 if you want to delete a bunch of project from a text file"
echo "#"
echo "Press 7 to leave this script"
read menuS

case "$menuS" in

"1")
clear
echo "You have picked the project creation !"
echo "Please enter the name of the project you want to create"
read projectName
curl --header "PRIVATE-TOKEN: UG3RFCZ861_ed8gzSvzc" -X POST "http://172.17.0.5/api/v4/projects?name="$projectName""
echo "The project has been created"
echo "You are now going back to the main menu"
sleep 2
exec /home/kam/Courses/GitLab/API-scripts/repoManagement.sh
;;

"2")
clear
echo "You have chosen to see the list of projects on the GitLab server !"
curl --header "PRIVATE-TOKEN: UG3RFCZ861_ed8gzSvzc" -X GET "http://172.17.0.5/api/v4/projects/" | jq '.'
echo "This is the end of the list of projects"
echo "Press any key to go back"
read -n 1 x; while read -n 1 -t .1 y; do x="$x$y"; done
echo "You are now going back to the main menu"
sleep 2
exec /home/kam/Courses/GitLab/API-scripts/repoManagement.sh
;;

"3")
clear
echo "You have picked the deletion of a project !"
echo "Please enter the id of the project you want to delete"
read projectId
curl --header "PRIVATE-TOKEN: UG3RFCZ861_ed8gzSvzc" -X DELETE "http://172.17.0.5/api/v4/projects/$projectId"
echo "The project has been deleted"
echo "You are now going back to the main menu"
sleep 2
exec /home/kam/Courses/GitLab/API-scripts/repoManagement.sh
;;

"4")
clear
echo "You have picked to check the users for a project"
echo "Please enter the id of the project"
read projectId
curl --header "PRIVATE-TOKEN: UG3RFCZ861_ed8gzSvzc" -X GET "http://172.17.0.5/api/v4/projects/$projectId/members" | jq '.'
echo "The is is the end of the members list"
echo "Press any key to go back"
read -n 1 x; while read -n 1 -t .1 y; do x="$x$y"; done
echo "You are now going back to the main menu"
sleep 2
exec /home/kam/Courses/GitLab/API-scripts/repoManagement.sh
;;

"5")
clear
echo "You have chosen to create a bunch of project from a text file !"
echo "Enter the name of the text file:"
read textFileName
#echo "Enter the location of the text file:"
#read pathToTextFile
#$file=$pathToTextFile/$textFileName 
echo "The list of project in $textFileName placed in $pathToTextFile will be created, are you sure ? Y/N"
read response
case "$response" in
    [yY][eE][sS]|[yY])
    echo "Let's go then !"
    sleep 1
    exec 4<$textFileName
    while read -u4 t; do
        echo $t
        curl --header "PRIVATE-TOKEN: UG3RFCZ861_ed8gzSvzc" -X POST "http://172.17.0.5/api/v4/projects?name="$t""
        echo "The project $t has been created"
    done
    ;;

    [nN][oO]|[nN])
    echo "no"
    echo "You are going back to the menu now"
    sleep 2
    ;;

    *)
    echo "This option is not available"
    echo "You are going back to the menu now"
    ;;

esac
sleep 2
exec /home/kam/Courses/GitLab/API-scripts/repoManagement.sh
;;

"6")
clear
echo "You have chosen to delete a bunch of project from a text file !"
echo "Enter the name of the text file:"
read textFileName
#echo "Enter the location of the text file:"
#read pathToTextFile
#$file=$pathToTextFile/$textFileName 
echo "The list of project in $textFileName placed in $pathToTextFile will be deleted, are you sure ? Y/N"
read response
case "$response" in
    [yY][eE][sS]|[yY])
    echo "Let's go then !"
    sleep 1
    exec 4<$textFileName
    while read -u4 t; do
        echo $t
        curl --header "PRIVATE-TOKEN: UG3RFCZ861_ed8gzSvzc" -X DELETE "http://172.17.0.5/api/v4/projects/$projectId"
        echo "The project $t has been deleted"
    done
    ;;

    [nN][oO]|[nN])
    echo "no"
    echo "You are going back to the menu now"
    sleep 2
    ;;

    *)
    echo "This option is not available"
    echo "You are going back to the menu now"
esac
sleep 2
exec /home/kam/Courses/GitLab/API-scripts/repoManagement.sh
;;

"7")
echo "You are leaving this script, goodby & see you soon"
sleep 2
clear
;;

*)
echo "This option is not available"
sleep 2
clear
exec /home/kam/COurses/GitLab/API-scritps/repoManagement.sh
;;

esac