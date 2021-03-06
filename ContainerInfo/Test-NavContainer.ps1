﻿<# 
 .Synopsis
  Test whether a Nav container exists
 .Description
  Returns $true if the Nav container with the specified name exists
 .Parameter containerName
  Name of the container which you want to check for existence
 .Example
  if (Test-NavContainer -containerName devcontainer) { dosomething }
#>
function Test-NavContainer {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$containerName
    )
    Process {
        $exist = $false
        docker ps --filter name="$containerName" -a -q --no-trunc | % {
            $name = Get-NavContainerName -containerId $_
            if ($name -eq $containerName) {
                $exist = $true
            }
        }
        $exist
    }
}
Export-ModuleMember -function Test-NavContainer
