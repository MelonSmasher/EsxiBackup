# ESXi Host PowerCLI Backup Utility

A simple script that backs up ESXi hosts.

---

## Install

1: Get the code

```powershell
git clone https://github.com/MelonSmasher/EsxiBackup.git;
cd EsxiBackup;
cp config.example.json config.json;
```

2: Open `config.json` with a text editor and configure the script

* `backup_repo` - Leave `backup_repo` set to `false` to use the local folder in this repo called `Backup`. You can also change this to a UNC network path or explicit folder path.
* `hosts` - Configure this JSON array with JSON objects with each hosts DNS or ip address, username, and password.
    * `address` - The host DNS name or IP address.
    * `user` - A user on the host. Usually root.
    * `pass` - The user password. Usually the root password.

3: Install the VMware PowerCLI

```powershell
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted;
Install-Module -Name VMware.PowerCLI;
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore;
```

## Usage

Backup:

```powershell
./EsxiBackup.ps1;
```

Restore:

```powershell
Connect-VIServer esxi-host-1.domain.tld -user root -password <password>;
Set-VMHost -VMHost esxi-host-1.domain.tld -State Maintenance;
Set-VMHostFirmware -vmhost esxi-host-1.domain.tld -Restore -Force -SourcePath C:\esxi_backups\configBundle-esxi-host-1.domain.tld.tgz -HostUser root -HostPassword <password>;
```
