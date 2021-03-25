function Update-DataGerryObject {
        <#
    .SYNOPSIS
        Updates an object thru the DataGerry API. Remember to set url/auth with Set-DataGerryAuth prior to running this function.
    .DESCRIPTION
        Updates an object thru the DataGerry API. Remember to set url/auth with Set-DataGerryAuth prior to running this function.
    .NOTES
        Name: Update-DataGerryObject
        Author: Morten Johansen
        Version: 0.0.1
        DateCreated: 2021-Mar-25
        DateUpdated: XXXX-XXX-XX
    .PARAMETER InputObj
        Parameter for the input object. The values "author_id" and "type_id" are mandatory in the DataGerry PUT method.
    .PARAMETER ObjectID
        Parameter for the object id to update in the DataGerry CMDB.
    .EXAMPLE
        $obj1 = [PSCustomObject]@{
            author_id  = 5
            type_id = 2
            fields = @(
                @{
                    "name" = "name"
                    "value" = 'server123'
                }
                @{
                    "name" = "os-domain"
                    "value" = "abcdef.com"
                }
            )
        }
        Update-DataGerryObject -InputObj $obj1 -ObjectID 61
        Will update the CI with id 61 in the DataGerry CMBD with the values from the input object.
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline,Mandatory=$true,Position=0)]
        [pscustomobject]$InputObj,
        [Parameter(Mandatory=$true,Position=1)]
        [int]$ObjectID
    )
    if (!$Global:DG_RestUrl -or !$Global:DG_ApiHeader) {
        Write-Host "Authentication and/or url for DataGerry not set, please use Set-DataGerryAuth" -ForegroundColor Red
        break
    }
    $objectApiURL = $Global:DG_RestUrl + 'object/' + $ObjectID
    foreach($obj in $InputObj) {
        $json = $obj | ConvertTo-Json
        if(($json | Test-Json) -eq $true) {
            try {
                Invoke-RestMethod -Method Put -Uri $objectApiURL -Headers $Global:DG_ApiHeader -ContentType "application/json" -Body $json
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