#!/bin/sh
##################################################################
#      remotebashrc.sh
#               Created by: Justyn Shull <justyn@justynshull.com>
#	For Updates, visit: http://www.justynshull.com/projects/remotebashrc.html 
#               Last Updated: 12/01/2009

#put this in your ~/.ssh/config file
#Host *
#ControlMaster auto
#ControlPath ~/.ssh/master-%r@%h:%p
#actually I lied..  You don't really need the above stuff anymore.  I added it to the commands below
#call it by ./remotebashrc.sh username port hostname
#use these two aliases 
#alias mst='~/remotebashrc.sh root 10222';
#alias root='~/remotebashrc.sh root 22';
#the host or ip needs to be the last argument for the scp command to work.. put other options first
#####################
# Usage: remotebashrc user port host
#   ex:  ./remotebashrc.sh root 22 10.0.0.2
# I have these aliases in my .bashrc:
#  alias mst='~/remotebashrc.sh root 10222';
#  alias root='~/remotebashrc.sh root 22';
# note:  doesn't really work on freebsd.. Mostly for lack of /bin/bash.   
#### 

##TODO
# random_file doesn't always work.   $RANDOM returns nothing some times. 
# check to see if it's a freebsd box before trying to ssh in..  /bin/bash doesn't seem to be installed by default
[ $# = 0 ] && { sed -n -e '/^# Usage:/,/^$/ s/^# \?//p' < $0; exit; }
beclean=1 #1 = don't automatically source the bashrc-remote, but still upload it.  0 = upload and use --rcfile to source it(looks bad in top/ps)
bashrc_remote=~/bashrc-remote
random_file=/tmp/rshrc-`date +%d%m%g%H%M%S`.$RANDOM 
#random_file=`mktemp -t remoteshrc`;
ruser=$1
rhost=$3
rport=$2

green="\033[01;32m";
ssh -NfnMS ~/.ssh/master-%r@%h:%p $ruser@$rhost -p $rport
scp -o ControlPath=~/.ssh/master-%r@%h:%p -P $rport $bashrc_remote $ruser@$rhost:$random_file
#ssh -S ~/.ssh/master-%r@%h:%p -l root $ruser bash --login -c 'source /tmp/bashrc-remotejs13;rm -f /tmp/bashrc-remotejs13'
if [ $beclean ]; then
	echo -e "$green once logged in, run: source $random_file \e[m"
	ssh -t -S ~/.ssh/master-%r@%h:%p $ruser@$rhost -p $rport
else
	ssh -t -S ~/.ssh/master-%r@%h:%p $ruser@$rhost -p $rport "bash --rcfile $random_file;rm -vf $random_file"
fi
#ssh -S ~/.ssh/master-%r@%h:%p -l root $1 "rm -vf /tmp/bashrc-remotejs13"
ssh -vO exit -S ~/.ssh/master-%r@%h:%p $ruser@$rhost -p $rport
