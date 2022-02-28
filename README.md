# Powershell-Firewall-Block-LOLbins
This PowerShell script will create new firewall rules that will block LOLbins (living-off-the-land binaries) from accessing the network.

For more information about this, you can refer here: https://www.cynet.com/attack-techniques-hands-on/what-are-lolbins-and-how-do-attackers-use-them-in-fileless-attacks/
In brief, this script will prevent built in Windows utilities from accessing the internet. For example, it will prevent the expand.exe from downloading a file from the internet. In most circumstances, using expand.exe to access a remote file is extremely unlikely and would most definitely be frowned upon if required for legitimate reasons.

I'm in the process of testing these in my environment and will make some comments if I discover any issues with a particular executable. Cscript and WMI blocks may be tricky or impossible to block using just a firewall rule.

I would like to credit these projects:
- https://github.com/atlantsecurity/windows-hardening-scripts/blob/main/windows-11-hardening-script . The executables in the firewall configuration found in this script are what inspired me to write this PowerShell script.
- https://lolbas-project.github.io/# - Good list of binaries to block
- https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-application-control/microsoft-recommended-block-rules
