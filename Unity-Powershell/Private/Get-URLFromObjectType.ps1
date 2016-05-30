function Get-URLFromObjectType {
  [CmdletBinding()]
  Param (
      [parameter(Mandatory = $true, HelpMessage = "IP/FQDN of the array")]
      [string]$Server,
      [Parameter(Mandatory = $true,HelpMessage = 'URI')]
      [string]$URI,
      [parameter(Mandatory = $true, HelpMessage = 'Type associated to the item')]
      [string]$TypeName,
      [parameter(Mandatory = $false, HelpMessage = 'Compact the response')]
      [switch]$Compact
  )

  Write-Verbose "Executing function: $($MyInvocation.MyCommand)"

  $object = New-Object $TypeName

  $object  | get-member -type Property | foreach-object {$fields += $_.Name + ','}

  #Remove last ,
  $fields = $fields -replace '.$'

  $URL = 'https://'+$Server+$URI+'?fields='+$fields

  If ($Compact) {
    $URL = $URL + '&compact=true'
  }

  return $URL
}
