function Get-MerakiDeviceSwitchPort {
    <#
    .SYNOPSIS
        Returns the switch ports for a switch
    .DESCRIPTION
        Returns the switch ports for a switch
    .PARAMETER Serial
        The Serial from the device that you want to return the ports. See Get-MerakiDevice
    .PARAMETER Number
    the number of the switch port that you want returned.
    .EXAMPLE
        PS C:\> $device | Get-MerakiDeviceSwitchPort
        Returns the ports from the device in $device
#>
    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName
        )]
        $Serial,

        [int]
        $Number
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/devices/$Serial/switchPorts"
        if ($Number) {
            $uri = "$(Get-MerakiUrl)/devices/$Serial/switchPorts/$Number"
        }
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

