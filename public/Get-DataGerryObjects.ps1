function Get-DataGerryObjects {
    <#
    .SYNOPSIS
        Returns object(s) from the DataGerry API. Remember to set url/auth with Set-DataGerryAuth prior to running this function.
    .DESCRIPTION
        Returns object(s) from the DataGerry API. Remember to set url/auth with Set-DataGerryAuth prior to running this function.
    .NOTES
        Name: Get-DataGerryObject
        Author: Morten Johansen
        Version: 0.0.1
        DateCreated: 2021-Mar-24
        DateUpdated: XXXX-XXX-XX
    .PARAMETER All
        By default the API will return 10 results. If you use the switch All the API will return 100000 results.
    .PARAMETER ObjectID
        Will return a specific object id from the DataGerry API.
    .EXAMPLE
        Get-DataGerryObject -ObjectID 2
        Will return the object with id 2 from the DataGerry API.
    .EXAMPLE
        Get-DataGerryObject -All
        Will return 100000 objects from the DataGerry API.
    .EXAMPLE
        Get-DataGerryObject
        Will return 10 objects from the DataGerry API.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false,Position=0)]
        [switch]$All,
        [Parameter(Mandatory=$false,Position=1)]
        [int]$ObjectID
    )
    if (!$Global:DG_RestUrl -or !$Global:DG_ApiHeader) {
        Write-Host "Authentication and/or url for DataGerry not set, please use Set-DataGerryAuth" -ForegroundColor Red
        break
    }
    if($All) {
        try {
            $objectApiURL = $Global:DG_RestUrl + 'objects/'
            $searchParameters = @{
                "limit" = '100000'
            }
            Invoke-RestMethod -Method Get -Uri $objectApiURL -Headers $Global:DG_ApiHeader -ContentType "application/json" -Body $searchParameters
        }
        catch {
            Write-Host "There was an error in your web request!" -ForegroundColor red
            Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
            break
        }
    } elseif ($ObjectID) {
        try {
            $objectApiURL = $Global:DG_RestUrl + 'object/' + $ObjectID
            Invoke-RestMethod -Method Get -Uri $objectApiURL -Headers $Global:DG_ApiHeader -ContentType "application/json"
        }
        catch {
            Write-Host "There was an error in your web request!" -ForegroundColor red
            Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
            break
        }
    } elseif ($ObjectID -and $All) {
        try {
            $searchParameters = @{
                "limit" = '100000'
            }
            $objectApiURL = $Global:DG_RestUrl + 'object/' + $ObjectID
            Invoke-RestMethod -Method Get -Uri $objectApiURL -Headers $Global:DG_ApiHeader -ContentType "application/json" -Body $searchParameters
        }
        catch {
            Write-Host "There was an error in your web request!" -ForegroundColor red
            Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
            break
        }
    } else {
        try {
            $objectApiURL = $Global:DG_RestUrl + 'objects/'
            Invoke-RestMethod -Method Get -Uri $objectApiURL -Headers $Global:DG_ApiHeader -ContentType "application/json"
        }
        catch {
            Write-Host "There was an error in your web request!" -ForegroundColor red
            Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
            break
        }
    }
}