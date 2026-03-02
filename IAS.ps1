[CmdletBinding()]
Param (
    [Parameter(Position=0)]
    [string]$DownloadURL = 'https://raw.githubusercontent.com/omartazul/IDM-Activation-Script/main/IAS.cmd',

    [Parameter(Position=1)]
    [string]$FallbackURL = '',

    [Parameter(Position=2)]
    [string]$ExpectedHash = '',

    [switch]$SkipHashCheck,
    [switch]$NoRun,

    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$ScriptArgs
)

$ErrorActionPreference = 'Stop'

function Write-Info { param([string]$msg) Write-Host "[INFO] $msg" }
function Write-Warn { param([string]$msg) Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function Write-Err  { param([string]$msg) Write-Host "[ERROR] $msg" -ForegroundColor Red }

function Initialize-Environment {
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
    } catch {
        Write-Verbose "TLS 1.2 setup warning: $_"
    }
}

function Get-SafeTempFilePath {
    $isAdmin = ([System.Security.Principal.WindowsPrincipal] [System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
    $TempDir = if ($isAdmin) { Join-Path $env:SystemRoot 'Temp' } else { $env:TEMP }
    if (-not (Test-Path $TempDir)) { New-Item $TempDir -ItemType Directory -Force | Out-Null }
    Join-Path $TempDir ("IAS_{0}.cmd" -f [System.Guid]::NewGuid())
}

function Get-RemoteFile {
    param([string]$PrimaryUrl, [string]$FallbackUrl, [string]$Destination)
    
    $download = {
        param($Url)
        try {
            Write-Info "Downloading: $Url"
            Invoke-WebRequest -Uri $Url -OutFile $Destination -UseBasicParsing -ErrorAction Stop
            return $true
        } catch {
            Write-Verbose "Download failed: $_"
            return $false
        }
    }
    
    $result = & $download $PrimaryUrl
    if (-not $result -and $FallbackUrl) {
        Write-Info "Trying fallback URL"
        $result = & $download $FallbackUrl
    }
    return $result
}

function Test-FileIntegrity {
    param([string]$Path, [string]$ExpectedHash)
    
    Write-Info "Verifying hash using SHA256"
    $computed = (Get-FileHash -Path $Path -Algorithm SHA256).Hash
    $computed -ieq $ExpectedHash
}

function Test-FileValidity {
    param([string]$Path)
    
    if (-not (Test-Path -LiteralPath $Path)) { throw "File does not exist" }
    if ((Get-Item -LiteralPath $Path).Length -eq 0) { throw "File is empty" }
    
    try {
        $firstLine = Get-Content -Path $Path -TotalCount 1 -ErrorAction Stop
        if ($firstLine -notmatch "^@(set|echo)") {
            Write-Warn "File may not be an IAS batch script"
        }
    } catch {
        Write-Verbose "Content validation skipped: $_"
    }
}

function Invoke-DownloadedScript {
    param([string]$Path, [string[]]$Arguments)
    
    $isAdmin = ([System.Security.Principal.WindowsPrincipal] [System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
    
    Write-Info "Starting process: $Path"
    $processParams = @{
        FilePath = $Path
        Wait     = $true
    }
    if ($Arguments) {
        $processParams['ArgumentList'] = $Arguments
    }
    if ($isAdmin) {
        $processParams['NoNewWindow'] = $true
    } else {
        $processParams['Verb'] = 'RunAs'
    }
    Start-Process @processParams
}

function Remove-TempFile {
    param([string]$Path)
    
    if (Test-Path -LiteralPath $Path) {
        Start-Sleep -Seconds 2
        Remove-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
        if (-not (Test-Path -LiteralPath $Path)) {
            Write-Info "Cleaned up $Path"
        } else {
            Write-Warn "Could not remove $Path (may still be in use). File is in temp directory and will be cleaned up later."
        }
    }
}

function Repair-LineEndings {
    param([string]$Path)
    
    Write-Verbose "Normalizing line endings to CRLF"
    $content = [System.IO.File]::ReadAllText($Path)
    $content = $content -replace "`r?`n", "`r`n"
    if (-not $content.EndsWith("`r`n")) { $content += "`r`n" }
    [System.IO.File]::WriteAllText($Path, $content, [System.Text.Encoding]::Default)
}

function Confirm-FileHash {
    param([string]$Path, [string]$Hash, [switch]$Skip)
    
    if (-not $Hash -or $Skip) { return }
    
    if (-not (Test-FileIntegrity -Path $Path -ExpectedHash $Hash)) {
        throw "Hash verification failed"
    }
    Write-Info "Hash check passed"
}

function Invoke-Main {
    if (-not $DownloadURL) { Write-Err "Download URL required"; return }
    
    Initialize-Environment
    $FilePath = Get-SafeTempFilePath
    $keepFile = $false
    
    try {
        if (-not (Get-RemoteFile -PrimaryUrl $DownloadURL -FallbackUrl $FallbackURL -Destination $FilePath)) {
            Write-Err "Download failed from all URLs"
            return
        }
        
        Confirm-FileHash -Path $FilePath -Hash $ExpectedHash -Skip:$SkipHashCheck
        Repair-LineEndings -Path $FilePath
        Test-FileValidity -Path $FilePath
        
        if ($NoRun) {
            $keepFile = $true
            Write-Info "Dry-run mode: File saved at $FilePath"
            return
        }
        
        Invoke-DownloadedScript -Path $FilePath -Arguments $ScriptArgs
        
    } catch {
        Write-Err "Operation failed: $_"
    } finally {
        if (-not $keepFile) { Remove-TempFile $FilePath }
    }
}

Invoke-Main
