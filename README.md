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

4: Either Enable or disable VMWare CEIP, this prevents a prompt each time the script is run

Enable:

```powershell
Set-PowerCLIConfiguration -Scope AllUsers -ParticipateInCEIP $true;
```

Disable:

```powershell
Set-PowerCLIConfiguration -Scope AllUsers -ParticipateInCEIP $false;
```

## Usage

### Backup

#### Method 1

From PowerShell:

```powershell
./EsxiBackup.ps1;
```

#### Method 2

From the GUI:

Double click on `run_backup.bat`.

### Restore

```powershell
Connect-VIServer esxi-host-1.domain.tld -user root -password <password>;
Set-VMHost -VMHost esxi-host-1.domain.tld -State Maintenance;
Set-VMHostFirmware -vmhost esxi-host-1.domain.tld -Restore -Force -SourcePath C:\esxi_backups\configBundle-esxi-host-1.domain.tld.tgz -HostUser root -HostPassword <password>;
```

## Extra Stuff

You can import my scheduled task to Windows Task Scheduler by importing `ESXi Backup Windows Task.xml` into Windows Task Scheduler. Make sure you've enabled or disabled the CEIP for all users before doing this.
