# set your working directory
$wd = "C:\dev\DataLab\Narrative\ps\"

# import the iManagePowershell module .dll
$wd + "iManagePowershell\iManagePowerShell.dll" | Import-Module 

# point this at a csv containing 'filesite ID' and 'version no'
$csv = @(Import-Csv C:\dev\DataLab\Narrative\ps\filesite_docs.csv)

# connect to the iManage database you want the files from
$d = Get-iManDatabase -Server BOE-DMS -Database Services

# loop through the filesite numbers and download each file to \docs
foreach($i in $csv){
    $d | Get-iManDocument -Number $i.'filesite ID' -Version $i.'version no' | Export-iManDocument docs
}
