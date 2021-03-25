function Get-DataGerryUsers {
    <#
    .SYNOPSIS
        Returns user(s) from the DataGerry API. Remember to set url/auth with Set-DataGerryAuth prior to running this function.
    .DESCRIPTION
        Returns user(s) from the DataGerry API. Remember to set url/auth with Set-DataGerryAuth prior to running this function.
    .NOTES
        Name: Get-DataGerryUsers
        Author: Morten Johansen
        Version: 1.0
        DateCreated: 2021-Mar-25
        DateUpdated: XXXX-XXX-XX
    .PARAMETER All
        By default the API will return 10 results. If you use the switch All the API will return 100000 results.
    .PARAMETER UserID
        Will return a specific user object from the DataGerry API.
    .EXAMPLE
        Get-DataGerryUsers -UserID 2
        Will return the user object with id 2 from the DataGerry API.
    .EXAMPLE
        Get-DataGerryUsers -All
        Will return 100000 user objects from the DataGerry API.
    .EXAMPLE
        Get-DataGerryUsers
        Will return 10 user objects from the DataGerry API (default).
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false,Position=0)]
        [switch]$All,
        [Parameter(Mandatory=$false,Position=1)]
        [int]$UserID
    )
    if (!$Global:DG_RestUrl -or !$Global:DG_ApiHeader) {
        Write-Host "Authentication and/or url for DataGerry not set, please use Set-DataGerryAuth" -ForegroundColor Red
        break
    }
    if($All) {
        try {
            $objectApiURL = $Global:DG_RestUrl + 'users/'
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
    } elseif ($UserID) {
        try {
            $objectApiURL = $Global:DG_RestUrl + 'user/' + $UserID
            Invoke-RestMethod -Method Get -Uri $objectApiURL -Headers $Global:DG_ApiHeader -ContentType "application/json"
        }
        catch {
            Write-Host "There was an error in your web request!" -ForegroundColor red
            Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
            break
        }
    } elseif ($UserID -and $All) {
        try {
            $searchParameters = @{
                "limit" = '100000'
            }
            $objectApiURL = $Global:DG_RestUrl + 'user/' + $TypeID
            Invoke-RestMethod -Method Get -Uri $objectApiURL -Headers $Global:DG_ApiHeader -ContentType "application/json" -Body $searchParameters
        }
        catch {
            Write-Host "There was an error in your web request!" -ForegroundColor red
            Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
            break
        }
    } else {
        try {
            $objectApiURL = $Global:DG_RestUrl + 'users/'
            Invoke-RestMethod -Method Get -Uri $objectApiURL -Headers $Global:DG_ApiHeader -ContentType "application/json"
        }
        catch {
            Write-Host "There was an error in your web request!" -ForegroundColor red
            Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
            break
        }
    }
}