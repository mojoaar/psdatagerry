<p align="center">
<a href="https://technet.cc"><img src="https://img.shields.io/badge/technet.cc-Blog-blue"></a>
<a href="https://twitter.com/mojoaar"><img src="https://img.shields.io/twitter/follow/mojoaar?style=social"></a>
</p>

# PSDATAGERRY - PowerShell Module
This PowerShell module provides a series of cmdlets for interacting with the [DATAGERRY Rest API](https://datagerry.com/). Invoke-RestMethod is used for all API calls.

## Requirements
Requires PowerShell 3.0 or above (this is when `Invoke-RestMethod` was introduced).

## Usage
Download or clone the latest files and place the module folder in your PowerShell profile directory (i.e. the `Modules` directory under wherever `$profile` points to in your PS console) and run:
`Import-Module PSDATAGERRY`
Once you've done this, all the cmdlets will be at your disposal, you can see a full list using `Get-Command -Module PSDATAGERRY`. Remember to run Set-DataGerryAuth before beginning to work in your environment.

## Cmdlets
* Get-DataGerryObjects
* Get-DataGerryTypes
* Get-DataGerryUsers
* New-DataGerryObject
* Set-DataGerryAuth
* Update-DataGerryObject

## Author
Author: Morten Johansen (<mj@emsg.net>) // [Twitter](https://twitter.com/mojoaar)
