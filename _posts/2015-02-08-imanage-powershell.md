---
layout: post
title:  "iManage Powershell module"
comments: true
date:   2015-02-02 12:00:00
categories: powershell imanage text mining data mining
featured_image: /images/hdf.gif
---

If your organisation uses [iManage](http://www.tikit.com/software/document-management/) as its content management system then the [iManage Powershell module](https://imanagepowershell.codeplex.com/) is a really powerful tool for mining that data. It allows you to write complex queries to filter documents of interest and downlad them to disc in native format.

Download the module and load it in to your PowerShell workspace, then point it at a folder, database, or specific files. The example below loops through a CSV of document ID's and version numbers and downloads them to disc.

```powershell
# import the iManagePowershell module .dll
"iManagePowerShell.dll" | Import-Module 

# point this at a csv containing 'ID' and 'version no'
$csv = @(Import-Csv \imanage_docs.csv)

# connect to the iManage database you want the files from
$d = Get-iManDatabase -Server imanage_server -Database imanage_database

# loop through the document numbers and download each file to \docs
foreach($i in $csv){
    $d | Get-iManDocument -Number $i.'ID' -Version $i.'version no' | Export-iManDocument docs
}
```