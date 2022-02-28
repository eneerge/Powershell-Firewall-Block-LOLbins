# Powershell-Firewall-Block-LOLbins
This Powershell script will will create new firewall rules that will block LOLbins (living-off-the-land binaries) from accessing the network. 

For more information about this, you can refer here: https://www.cynet.com/attack-techniques-hands-on/what-are-lolbins-and-how-do-attackers-use-them-in-fileless-attacks/

In brief, this script will prevent built in Windows utitlies from accessing the internet. For example, it will prevent the expand.exe from downloading a file from the internet.
In most circumstances, using expand.exe to access a remote file is extremely unlikely and definitely frowned upon to be used in this way.

I'm in the process of testing these in my environment and will make some comments if I discover any issues with a particular executable. cscript and wmi blocks may be tricky or impossible 
to block using just a firewall rule.
