function Set-DataGerryAuth {
    <#
    .SYNOPSIS
        Set's the Authorization and Rest URL to the DataGerry API
    .DESCRIPTION
        Set's the Authorization and Rest URL to the DataGerry API
    .NOTES
        Name: Set-DataGerryAuth
        Author: Morten Johansen
        Version: 1.0
        DateCreated: 2021-Mar-24
        DateUpdated: XXXX-XXX-XX
    .PARAMETER Url
        Parameter for the DataGerry Rest API endpoint. Mandatory parameter.
    .PARAMETER Credential
        Parameter for the PSCredential object to authenticate with the DataGerry API. Mandatory parameter.
    .EXAMPLE
        $cred = Get-Credential
        Set-DataGerryAuth -Url 'https://datagerry.host.com:4000/rest/' -Credential $cred
        Will set the url and authentication from the input in $cred.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0)]
        [string]$Url,
        [Parameter(Mandatory=$true,Position=1)]
        [PSCredential]$Credential
    )
    try {
        $password = $Credential.GetNetworkCredential().password
		$key = [string]::Format("{0}:{1}", $Credential.UserName, $password)
		$authorization = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($key))
        Set-Variable -Name DG_RestUrl -Scope Global -Value $Url
        Set-Variable -Name DG_Username -Scope Global -Value $Credential.UserName
        Set-Variable -Name DG_Password -Scope Global -Value $password
        Set-Variable -Name DG_ApiHeader -Scope Global -Value @{Authorization = "Basic $($authorization)"}
        Set-Variable -Name DG_SearchLimit -Scope Global -Value 100000
    }
    catch {
        Write-Host "Failed to set the global variables!" -ForegroundColor red
        Write-Host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
        break
    }
}