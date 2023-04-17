<# 
.SYNOPSIS
    This function is used to define flagged graph api permissions.
.DESCRIPTION
    Produces an array of flagged graph permissions to be in used in comparison operations.
.NOTES
    This is a custom function written by Mark Connelly, so it may not work as intended.
.LINK
    https://github.com/markdconnelly/MarkConnellyPowerShellModule/blob/main/Functions/Utility/Get-FlaggedAzureADRoleArray.ps1
.EXAMPLE
    $variable = Get-FlaggedAzureADRoleArray
#>

Function Get-FlaggedAzureADRoleArray {
    [CmdletBinding()]
    Param ()

    $GraphAppId = "00000003-0000-0000-c000-000000000000"
    $GraphServicePrincipal = Get-MgServicePrincipal -Filter "appId eq '$GraphAppId'"
    $GraphServicePrincipal | ConvertTo-Json -Depth 10 | Out-File -LiteralPath "C:\temp\GraphServicePrincipal.json" -Force
    
    $flaggedAppRoles = $GraphServicePrincipal.AppRoles | Where-Object {($_.Value -like "*AccessReview*" -or `
                                                                        $_.Value -like "*AdministrativeUnit*" -or `
                                                                        $_.Value -like "*APIConnectors*" -or `
                                                                        $_.Value -like "*Application*" -or `
                                                                        $_.Value -like "*AppRoleAssignment*" -or `
                                                                        $_.Value -like "*CustomSecAttribute*" -or `
                                                                        $_.Value -like "*AuditLog*" -or `
                                                                        $_.Value -like "*AuthenticationContext*" -or `
                                                                        $_.Value -like "*BitlockerKey*" -or `
                                                                        $_.Value -like "*ChannelMessage*" -or `
                                                                        $_.Value -like "*Contacts*" -or `
                                                                        $_.Value -like "*ConsentRequest*" -or `
                                                                        $_.Value -like "*Device*" -or `
                                                                        $_.Value -like "*Directory.ReadWrite*" -or `
                                                                        $_.Value -like "*Domain*" -or `
                                                                        $_.Value -like "*Files.Read*" -or `
                                                                        $_.Value -like "*Group*" -or `
                                                                        $_.Value -like "*Identity*" -or `
                                                                        $_.Value -like "*DeviceManagementApps*" -or `
                                                                        $_.Value -like "*DeviceManagementConfiguration*" -or `
                                                                        $_.Value -like "*DeviceManagementManagedDevices*" -or `
                                                                        $_.Value -like "*DeviceManagementRBAC*" -or `
                                                                        $_.Value -like "*Mail*" -or `
                                                                        $_.Value -like "*Organization*" -or `
                                                                        $_.Value -like "*PrivilegedAccess*" -or `
                                                                        $_.Value -like "*Policy*" -or `
                                                                        $_.Value -like "*RoleManagement*" -or `
                                                                        $_.Value -like "*Security*" -or `
                                                                        $_.Value -like "*User*") -and `
                                                                        $_.AllowedMemberTypes -contains "Application"} `
                                                                        | Select-Object Id, Value, DisplayName
}