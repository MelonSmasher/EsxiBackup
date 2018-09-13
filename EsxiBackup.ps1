# Read the config
$config = (Get-Content config.json) -join "`n" | ConvertFrom-Json

# Run the backup
foreach ($h in $config.hosts) {
    Connect-VIServer $h.address -user $h.user -password $h.pass;
    Get-VMHostFirmware -vmhost $h.address -BackupConfiguration -DestinationPath $config.backup_repo;
}