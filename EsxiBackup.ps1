# Read the config
$config = (Get-Content (Join-Path $PSScriptRoot config.json)) -join "`n" | ConvertFrom-Json

# Create a new backup destination folder
if (!$config.backup_repo) { $config.backup_repo = (Join-Path $PSScriptRoot 'Backups'); }
$repo = Join-Path $config.backup_repo (get-date).ToString('yyyy-MM-dd_hh-mm-ss-tt');
New-Item -ItemType directory -Path $repo -Force -Recurse;

# Run the backup
foreach ($h in $config.hosts) {
    Connect-VIServer $h.address -user $h.user -password $h.pass;
    Get-VMHostFirmware -vmhost $h.address -BackupConfiguration -DestinationPath $repo;
    Disconnect-VIServer $h.address -Force -Confirm:$false;
}