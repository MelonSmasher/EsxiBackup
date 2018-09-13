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

2: Open `config.json` with a text editor and configure each host you want to back up and the backup repo path.

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
