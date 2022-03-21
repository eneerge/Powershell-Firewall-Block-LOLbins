Import-Module -Name 'NetSecurity'

# [ config ]

# This will set a prefix for the rule name so it can be easily identified in the Windows Firewall wf.msc.
$rulePrefix = "#LOLbins"

# If set to $false, rules will not be created for apps that do not exist on the computer.
# If set to $true, rules will be created even for apps that do not exist
# When setting to false, it will reduce the number of rules that are created and speed up rule processing, but if an app is installed in the future, then it will not be blocked until the script is rerun
# If you have RMM software, you could just set this to false and then run the script daily, or you can just rerun the script when software is installed.
$createRulesForNonExistingApps = $false;


# [ script ]

function CreateBlockRule {
  param ([string] $ruleName, [string] $exePath)

  $found = Get-NetFirewallRule | Where { 
    $_.DisplayName -eq "$rulePrefix - $ruleName" `
  }

  # If the exe does not exist on the machine, then don't create it
  if (!$createRulesForNonExistingApps -and !(Test-Path -Path $exePath)) {

    # Delete the existing rule if it was found
    if ($found) {
        Remove-NetFirewallRule -DisplayName "$rulePrefix - $ruleName"
        Write-Host "Deleted " -NoNewLine
        Write-Host -ForegroundColor Cyan "$ruleName " -NoNewLine
        Write-Host "because application is not installed."
    }
    else {
        Write-Host "Skipped " -NoNewLine
        Write-Host -ForegroundColor Cyan "$ruleName " -NoNewLine
        Write-Host "because application is not installed."
    }

    return;
  }

  # Exists, update the existing rule
  if ($found) {
    $out = Set-NetFirewallRule -DisplayName "$rulePrefix - $ruleName" `
        -Enabled True `
        -Profile Any `
        -Action Block `
        -Program "$exePath" `
        -EdgeTraversalPolicy Block `
        -Direction Outbound

    Write-Host "Updated " -NoNewLine
    Write-Host "$ruleName" -ForegroundColor Cyan
  }

  # Doesn't exist, create it
  else {
    $out = New-NetFirewallRule -DisplayName "$rulePrefix - $ruleName" `
        -Enabled True `
        -Profile Any `
        -Action Block `
        -Program "$exePath" `
        -EdgeTraversalPolicy Block `
        -Direction Outbound

    Write-Host "Created " -NoNewLine
    Write-Host "$ruleName" -ForegroundColor Cyan
  }
}

# This searches for the specified executable file in System root and creates block rules for all versions that exists
function CreateSystemBlockRule {
    param ([string] $ruleName, [string] $exeFile)

    if ($ruleName.Length -eq 0) {
      $ruleName = $exeFile
    }

    # Locate all versions of this executable in System Root
    $exes = gci -Path "$env:SystemRoot\\" -recurse "$exeFile" -ErrorAction SilentlyContinue
    for ($i=1; $i -lt $exes.Count; $i++) {
        $exe = $exes[$i].FullName
        CreateBlockRule -ruleName "$rulename ($exe)" -exePath "$exe"
    }
}


# CreateBlockRule blocks the specific application path without searching for alternative locations
CreateBlockRule -ruleName "AppVLP.exe - Application Virtualization Utility Included with Microsoft Office (x64 Office)" -exePath "$env:ProgramFiles\Microsoft Office\root\client\AppVLP.exe"
CreateBlockRule -ruleName "AppVLP.exe - Application Virtualization Utility Included with Microsoft Office" -exePath "$env:ProgramFiles(x86)\Microsoft Office\root\client\AppVLP.exe"

# CreateSystemBlockRule will look for alternative locations of the specified executable and block all that is found.
CreateSystemBlockRule -exeFile "at.exe"
CreateSystemBlockRule -exeFile "atbroker.exe"
CreateSystemBlockRule -exeFile "certutil.exe"
CreateSystemBlockRule -exeFile "addinprocess.exe"
CreateSystemBlockRule -exeFile "addinprocess32.exe"
CreateSystemBlockRule -exeFile "addinutil.exe"
CreateSystemBlockRule -exeFile "aspnet_compiler.exe"
CreateSystemBlockRule -exeFile "bash.exe"
#CreateSystemBlockRule -exeFile "bginfo.exe1"
CreateSystemBlockRule -exeFile "certOC.exe"
CreateSystemBlockRule -exeFile "cdb.exe"
CreateSystemBlockRule -exeFile "cscript.exe"
CreateSystemBlockRule -exeFile "control.exe"
CreateSystemBlockRule -exeFile "cscript.exe"
CreateSystemBlockRule -exeFile "csc.exe"
CreateSystemBlockRule -exeFile "csi.exe"
CreateSystemBlockRule -exeFile "dbghost.exe"
CreateSystemBlockRule -exeFile "dbgsvc.exe"
CreateSystemBlockRule -exeFile "dnx.exe"
CreateSystemBlockRule -exeFile "dotnet.exe"
CreateSystemBlockRule -exeFile "expand.exe"
CreateSystemBlockRule -exeFile "findstr.exe"
CreateSystemBlockRule -exeFile "forefiles.exe"
CreateSystemBlockRule -exeFile "fsi.exe"
CreateSystemBlockRule -exeFile "fsiAnyCpu.exe"
CreateSystemBlockRule -exeFile "hh.exe"
CreateSystemBlockRule -exeFile "infdefaultinstall.exe"
CreateSystemBlockRule -exeFile "kd.exe"
CreateSystemBlockRule -exeFile "kill.exe"
CreateSystemBlockRule -exeFile "lxrun.exe"
CreateSystemBlockRule -exeFile "Makecab.exe"
CreateSystemBlockRule -exeFile "Microsoft.Workflow.Compiler.exe"
CreateSystemBlockRule -exeFile "msbuild.exe2"
CreateSystemBlockRule -exeFile "mshta.exe"
CreateSystemBlockRule -exeFile "ntkd.exe"
CreateSystemBlockRule -exeFile "ntsd.exe"
CreateSystemBlockRule -exeFile "powershellcustomhost.exe"
CreateSystemBlockRule -exeFile "rcsi.exe"
CreateSystemBlockRule -exeFile "runscripthelper.exe"
CreateSystemBlockRule -exeFile "texttransform.exe"
CreateSystemBlockRule -exeFile "visualuiaverifynative.exe"
CreateSystemBlockRule -exeFile "wfc.exe"
CreateSystemBlockRule -exeFile "windbg.exe"
CreateSystemBlockRule -exeFile "wmic.exe"
CreateSystemBlockRule -exeFile "wscript.exe"
CreateSystemBlockRule -exeFile "wsl.exe"
CreateSystemBlockRule -exeFile "wslconfig.exe"
CreateSystemBlockRule -exeFile "wslhost.exe"
