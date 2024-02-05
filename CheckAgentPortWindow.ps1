$PortNumber = 50051
$Connections = Get-NetTCPConnection -LocalPort $PortNumber -ErrorAction SilentlyContinue

if ($Connections) {
    $Connections | ForEach-Object {
        $Process = Get-Process -Id $_.OwningProcess
        [PSCustomObject]@{
            "ProcessName"      = $Process.ProcessName
            "PID"               = $Process.Id
            "LocalAddress"      = $_.LocalAddress
            "LocalPort"         = $_.LocalPort
            "ForeignAddress"    = $_.RemoteAddress
            "ForeignPort"       = $_.RemotePort
            "State"             = $_.State
            "MainWindowTitle"   = $Process.MainWindowTitle
            "StartTime"         = $Process.StartTime
        }
    } | Format-Table -AutoSize
} else {
    Write-Host "No processes found using port $PortNumber"
}
