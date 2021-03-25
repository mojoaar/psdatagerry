function New-DataGerryObject {
    <#
    .SYNOPSIS
        Creates a object thru the DataGerry API. Remember to set url/auth with Set-DataGerryAuth prior to running this function.
    .DESCRIPTION
        Creates a object thru the DataGerry API. Remember to set url/auth with Set-DataGerryAuth prior to running this function.
    .NOTES
        Name: New-DataGerryObject
        Author: Morten Johansen (mojo)
        Version: 1.0
        DateCreated: 2021-Mar-25
        DateUpdated: XXXX-XXX-XX
    .PARAMETER InputObj
        Parameter for the input object. The values "author_id" and "type_id" are mandatory in the DataGerry POST method.
    .EXAMPLE
        $obj1 = [PSCustomObject]@{
            author_id  = 5
            type_id = 2
            fields = @(
                @{
                    "name" = "name"
                    "value" = 'server1'
                }
                @{
                    "name" = "os-domain"
                    "value" = "abc.com"
                }
            )
        }
        $obj2 = [PSCustomObject]@{
            author_id  = 5
            type_id = 2
            fields = @(
                @{
                    "name" = "name"
                    "value" = 'server2'
                }
                @{
                    "name" = "os-domain"
                    "value" = "abc.com"
                }
            )
        }
        New-DataGerryObject -InputObj $obj1,$obj2
        Will create two new CI's in the DataGerry CMBD from the two input objects.
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline,Mandatory=$true)]
        [pscustomobject]$InputObj
    )
    if (!$Global:DG_RestUrl -or !$Global:DG_ApiHeader) {
        Write-Host "Authentication and/or url for DataGerry not set, please use Set-DataGerryAuth" -ForegroundColor Red
        break
    }
    $objectApiURL = $Global:DG_RestUrl + 'object/'
    foreach($obj in $InputObj) {
        $json = $obj | ConvertTo-Json
        if(($json | Test-Json) -eq $true) {
            try {
                Invoke-RestMethod -Method Post -Uri $objectApiURL -Headers $Global:DG_ApiHeader -ContentType "application/json" -Body $json
            }
            catch {
                Write-Host "There was an error in your web request!" -ForegroundColor Red
                Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
                break
            }
        } else {
            Write-Host "There was a problem with the json" -ForegroundColor Red
        }
    }
}