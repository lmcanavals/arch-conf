#!/bin/bash
#define the filename to use as output
motd="/etc/motd"
# Collect useful information about your system
# $USER is automatically defined
HOSTNAME=`uname -n`
KERNEL=`uname -r`
CPU=`uname -p`
ARCH=`uname -m`
# The different colours as variables
R="\033[01;31m"
Y="\033[01;33m"
B="\033[01;34m" 
W="\033[01;37m"
X="\033[00;37m"
clear > $motd # to clear the screen when showing up
echo -e "$B         ." >> $motd
echo -e "$B        / \\" >> $motd
echo -e "$B       /   \\    $W ,---.          |      $B  |    o" >> $motd
echo -e "$B      /^.   \\   $W |---|,---.,---.|---.  $B  |    .,---..   ..  ," >> $motd
echo -e "$B     /  .-.  \\  $W |   ||    |    |   |  $B  |    ||   ||   | ><" >> $motd
echo -e "$B    /  (   ) _\\ $W '   ''    '---''   '  $B  '---'''   ''---''  '" >> $motd
echo -e "$B   / _.~   ~._^\\" >> $motd
echo -e "$B  /.^         ^.\\ $Y  hosted by Contabo!" >> $motd
echo -e "$X" >> $motd

