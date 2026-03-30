# IDM Activation Script

Lightweight Windows tooling for IDM state management via batch and PowerShell.

## Features

- Interactive menu for common operations
- Command-line support for unattended use
- Automatic registry backup before changes
- Deterministic hosts normalization with duplicate-safe IDM domain blocking
- Compatibility checks for environment, permissions, and required tools
- Support for x86, x64, and ARM64 Windows environments

## Requirements

- Windows 7 or later (including Windows Server)
- Administrator privileges
- Windows PowerShell 5.1 or later
- Internet Download Manager installed

## Usage

### Method 1: PowerShell bootstrap

Run in Windows PowerShell:

```powershell
irm https://raw.githubusercontent.com/omartazul/IDM-Activation-Script/main/IAS.ps1 | iex
```

### Method 2: Interactive mode

1. Download IAS.cmd from the Releases page.
2. Run IAS.cmd as Administrator.
3. Select an option from the menu.

### Method 3: Command-line mode

```cmd
IAS.cmd /act
IAS.cmd /frz
IAS.cmd /res
```

## Operational flow

1. Validate execution environment and privileges.
2. Detect IDM and related registry locations.
3. Create backup files in %TEMP% (with fallback to %SystemRoot%\Temp).
4. Execute the selected operation.
5. Return status and guidance in the console.

## Troubleshooting

### Script requires admin privileges

- Run the script with elevated rights.

### PowerShell is not working

- Check policy restrictions.
- Example:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass
```

### WMI is not working

- Restart the service:

```cmd
net start winmgmt
```

### Hosts entries look inconsistent

- Run the script once with administrator privileges to re-normalize IDM domains.
- The script now rewrites managed IDM hosts entries idempotently on each run.

## Security and privacy

- Operations are local to the machine.
- Registry backups are created before modification.
- Source is visible and reviewable.

## Compatibility

| Windows Version | Status |
|-----------------|--------|
| Windows 11      | Supported |
| Windows 10      | Supported |
| Windows 8.1 / 8 | Supported |
| Windows 7       | Supported |
| Windows Server  | Supported |

| Architecture | Status |
|--------------|--------|
| x64          | Supported |
| x86          | Supported |
| ARM64        | Supported |

## License

This project is licensed under the MIT License. See LICENSE for details.

## Disclaimer

Use this repository responsibly and in compliance with applicable laws, software terms, and licensing requirements.

## Author

Md. Omar Faruk Tazul Islam
- GitHub: [@omartazul](https://github.com/omartazul)

## Contributing

Contributions are welcome. See CONTRIBUTING.md for contribution guidelines.
