# IDM Activation Script - Project Summary

## Overview

This repository contains a Windows batch workflow and a PowerShell bootstrap wrapper for IDM state and registry management. The project focuses on compatibility checks, operational safety, and clear console guidance.

## Repository structure

```text
IDM-Activation-Script/
|-- IAS.cmd
|-- IAS.ps1
|-- README.md
|-- CONTRIBUTING.md
|-- CHANGELOG.md
|-- LICENSE
`-- PROJECT_SUMMARY.md
```

**Version:** 3.1.1

## Components

### IAS.cmd

- Primary interactive and command-line entry point
- Environment validation and privilege checks
- Registry backup and operation orchestration
- Idempotent IDM hosts normalization and domain-block enforcement
- User-facing status and error reporting

### IAS.ps1

- Downloads IAS.cmd from configured source
- Optional SHA-256 hash verification
- Basic file validation and line-ending normalization
- Temporary file cleanup after execution

## Supported environments

- Windows 7, 8, 8.1, 10, 11, and Windows Server variants
- x86, x64, and ARM64 architectures
- PowerShell 5.1+

## Execution modes

### Interactive mode

Launch IAS.cmd and choose an option from the menu.

### Unattended mode

Use one of the supported flags:

- /act
- /frz
- /res

## Reliability and safety

- Preflight checks for required runtime components
- Administrator enforcement before protected operations
- Registry backup before modifications (stored in %TEMP% with safe fallback)
- Managed hosts entries are normalized on each run to prevent duplicates
- Error paths with user-readable guidance

## Contribution flow

Contributions are managed through pull requests. See CONTRIBUTING.md for standards, testing expectations, and review process.

## License

MIT License. See LICENSE for full text.
