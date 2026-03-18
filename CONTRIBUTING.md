# Contributing to IDM Activation Script

Thank you for your interest in contributing. This guide explains how to propose changes, submit code, and keep contributions consistent with project standards.

## Code of conduct

- Be respectful and constructive.
- Keep discussions focused on the technical issue.
- Accept feedback professionally.

## How to contribute

### Report bugs

Before opening a new issue, check existing issues to avoid duplicates.

Include the following information:

- Clear summary of the problem
- Steps to reproduce
- Expected behavior and actual behavior
- Environment details:
  - Windows version and build
  - IDM version
  - Architecture (x86, x64, ARM64)
  - PowerShell version

### Suggest enhancements

Provide:

- Clear feature summary
- Problem statement and expected outcome
- Practical use case
- Optional implementation ideas

### Submit code changes

1. Fork the repository.
2. Clone your fork locally.
3. Create a branch for your change.
4. Implement the change with tests where applicable.
5. Run validation and smoke checks.
6. Commit with a clear message.
7. Push your branch.
8. Open a pull request against main.

## Development setup

### Prerequisites

- Windows 7 or later
- PowerShell 5.1 or later
- Git
- A code editor
- IDM installed for testing

### Validation checklist

- Test on at least one clean environment.
- Verify behavior on Windows 10 and 11 when possible.
- Cover no-admin and missing-IDM scenarios.
- Check unattended flags and interactive mode.

## Coding standards

### Batch script (.cmd)

- Use descriptive variable names.
- Keep section blocks organized and readable.
- Add comments only where behavior is non-obvious.
- Preserve existing style and command conventions.

### PowerShell (.ps1)

- Prefer verb-noun naming.
- Use explicit error handling where needed.
- Keep functions focused and testable.
- Avoid unnecessary side effects.

## Pull request process

1. Update documentation for user-facing changes.
2. Add a changelog entry when appropriate.
3. Describe what changed and why.
4. Link related issues.
5. Complete self-review before requesting review.

## Versioning

This project follows Semantic Versioning:

- MAJOR: incompatible changes
- MINOR: backward-compatible features
- PATCH: backward-compatible fixes

When releasing, keep version references aligned across IAS.cmd, README.md, and CHANGELOG.md.

## License

By contributing, you agree your contributions are licensed under the MIT License.
