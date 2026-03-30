# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.1.1] - 2026-03-31

### Changed
- Hardened temporary-path handling to use `%TEMP%` first with safe fallback behavior.
- Improved hosts-file write reliability across repeated runs.

### Fixed
- Fixed privilege setup in the registry permission routine to avoid intermittent lock failures.
- Fixed edge cases where protected or missing registry keys could terminate the scan flow.
- Fixed IDM hosts block behavior to normalize managed domains idempotently and prevent duplicate entries.

## [3.1.0] - 2026-03-18

### Changed
- Modernized codebase and overhauled documentation.
- Refactored IAS.cmd into modular functions and improved execution reliability.
- Enhanced IAS.ps1 with better error handling and administrator checks.
- Implemented IDM host blocking and more robust registry key detection logic.

## [3.0.0] - 2025-12-04

### Added
- **Initial Public Release:** Comprehensive rewrite and branding.
- **Interactive Interface:** User-friendly menu system with color-coded CLI output.
- **Core Capabilities:**
  - Full IDM activation functionality.
  - Trial period freeze feature (Highly Recommended).
  - Reset activation and trial option.
- **System Safety:** Automatic registry backup system implemented before any modifications.
- **Smart Detection:** Intelligent CLSID registry key detection and management.
- **Architecture Support:** Native compatibility with x86, x64, and ARM64 architectures.
- **Automation:** Command-line parameters for unattended operation (`/act`, `/frz`, `/res`).
- **Robust Engine:** PowerShell-based registry scanning engine for reliable execution.
- **Validation:** Internet connectivity verification and IDM process management (auto-kill).
- **OS Compatibility:** Full support for Windows 7, 8, 8.1, 10, 11, and Windows Server editions.

### Technical Improvements
- Added PowerShell execution environment validation.
- Enforced strict Administrator privilege checks.
- Implemented QuickEdit mode handling for an improved user experience.
- Added Terminal/ConHost compatibility layer for modern Windows environments.
- Developed session-aware user SID detection.
- Included HKCU/HKU registry synchronization verification.

### Documentation
- Added a comprehensive README with usage instructions.
- Added contribution guidelines.
- Added a project summary document.
- Included MIT License.

---

## Release Notes

### v3.0.0 - Initial Release

This release marks the first public version of the modernized IDM Activation Script. The codebase has been meticulously designed with a focus on:

1. **Reliability:** Robust error handling and system validation at every step.
2. **Safety:** Automatic timestamped backups prior to any registry modifications.
3. **Compatibility:** Extensive support across various Windows versions and system architectures.
4. **Usability:** A clean, intuitive interface with helpful on-screen guidance.
5. **Flexibility:** Multiple operational modes, including both interactive and command-line execution.

This script combines practical activation-management workflows with a maintainable, dependency-light architecture based on standard Windows components.

### Known Limitations
- Administrator privileges are strictly required.
- An active internet connection is necessary during the initial setup phase.
- Certain antivirus software may flag the script as a false positive due to registry manipulation.
- May not function with highly customized or heavily modified IDM installations.

### Recommendations
- Utilize the **"Freeze Trial"** option for the most stable, long-term results.
- Ensure Windows and PowerShell components are up to date.
- While the script creates automatic backups, maintaining a manual system restore point is always good practice.

---
[Unreleased]: https://github.com/omartazul/IDM-Activation-Script/compare/v3.1.1...HEAD
[3.1.1]: https://github.com/omartazul/IDM-Activation-Script/releases/tag/v3.1.1
[3.1.0]: https://github.com/omartazul/IDM-Activation-Script/releases/tag/v3.1.0
[3.0.0]: https://github.com/omartazul/IDM-Activation-Script/releases/tag/v3.0.0
