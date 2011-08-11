RemoteBashRC.sh
===============
What is it?
-----------
I work doing tech support for a dedicated server hosting company. So naturally, we deal with lots of servers every day, and one of the guys I work with said something like “I wish all my aliases would follow me to other servers”. That sounded like a cool idea to me, and basically explains what the script does. It will open a persistant ssh connection to the server you specify, use scp to copy $bashrc_remote to /tmp on the server, initiate an actual ssh session invoking bash with the –rcfile option to automatically source the bashrc_remote file, and then delete it when you exit the remote shell. Since I’m using persistant ssh connections, this will only ask you for the remote password once. Any additional ssh connections to the same server/user/port while the script is running automatically re-uses the connection.


 
How do I use it?
----------------
Download the script from below. You can either use the included bashrc-remote which has some useful aliases added to it already(including a lot of plesk-specific ones that only get sourced if plesk’s installed), or you can choose to use your own bashrc. Open up remotebashrc.sh in a text editor, and change the bashrc_remote variable to the location of the bashrc you want to use. By default, it’s set to ~/bashrc-remote because I like to keep a separate .bashrc on my local shell with functions and aliases I don’t want on other servers.


 
You can run it like this: remotebashrc user port host
Example: ./remotebashrc.sh root 22 10.0.0.2

Until I clean it up, you can add alias like this to your .bashrc file:
alias root=’~/remotebashrc.sh root 22′;
Then to connect to a remote server using the root server, all you need to do is type ‘root myserver.com’


 
Download

From SVN

[note 08/16/2010:  I just switched justynshull.com over to my vps instead of dreamhost, so subversion isn't working yet.    E-mail me if you really want the latest version]
You can check this script out from a public read-only svn repo by issuing this command:
svn co http://justynshull.com/dev/remotebashrc/ remotebashrc
And to update, just type: svn up

Tarball

Download the latest [stable] version here(12/01/09): remotebashrc.tar.gz

ChangeLog
---------
11/30/2009
- Initial commit to svn
12/01/2009
- by default, the script only uploads the bashrc file now and tells you to source it manually. bashrc-remote also automatically tries to delete itself after you source it now
12/02/2009
- added some new aliases to the bashrc-remote file (lla, llah, :q, :q!, and :wq)
- added a couple commands to the end of bashrc-remote to display the servers uptime/load and total processes when you first log in
- added a line to show the currently running services.. kind of.. It uses an array of process names, and pidof to see if they’re running
- if ~/.bashrc exists, source it before doing anything else. bashrc_remote will overwrite anything in it though
- changed the default PS1 prompt.
- added /sbin and /usr/sbin to PATH
- added a $debug option to remotebashrc.sh
02/14/2010
- changed $bashrc_remote to look for bashrc-remote in the same directory as remotebashrc.sh instead of ~/
