<#
.SYNOPSIS
  Extracts package versions from Ocaramba.csproj and exposes them as
  GitHub Actions outputs (GITHUB_OUTPUT).

.DESCRIPTION
  - Downloads Ocaramba.csproj from GitHub
  - Handles UTF-8 BOM and whitespace safely
  - Parses <PackageReference> items into a dictionary
  - Fetches latest Ocaramba tag from GitHub
  - Emits versions as outputs for use in workflows:
      - SeleniumWebDriverVersion
      - SeleniumSupportVersion
      - SeleniumWebdriverChromeDriverVersion
      - SeleniumWebDriverGeckoDriverVersion
      - SeleniumWebDriverIEDriverVersion
      - SeleniumWebDriverMSEdgeDriverVersion
      - NUnitVersion
      - NUnit3TestAdapterVersion
      - MicrosoftNetTestSdkVersion
      - MSTestTestAdapterVersion
      - MSTestTestFrameworkVersion
      - NPOIVersion
      - NLogVersion
      - SystemTextJsonVersion
      - SystemTextEncodingsWebVersion
      - OcarambaVersion
#>

$ErrorActionPreference = "Stop"

# ------------------------------------------------------------
# CONFIG
# ------------------------------------------------------------

# csproj location (raw)
$csprojUrl   = "https://raw.githubusercontent.com/Accenture/Ocaramba/master/Ocaramba/Ocaramba.csproj"

# tags API for Ocaramba repo
$repoApiTags = "https://api.github.com/repos/Accenture/Ocaramba/tags"

# GitHub Actions output file
$OutputFile = $env:GITHUB_OUTPUT
if (-not $OutputFile) {
    Write-Warning "GITHUB_OUTPUT not set. Falling back to ./local_output.txt (local run mode)."
    $OutputFile = "./local_output.txt"
}

# ------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------

function Get-PackageVersionsFromCsproj {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Url
    )

    Write-Host "Downloading csproj from $Url ..."

    $response = Invoke-WebRequest -Uri $Url -UseBasicParsing

    if (-not $response.Content) {
        throw "Empty response from $Url"
    }

    # Raw string may contain UTF-8 BOM and extra whitespace
    $raw = $response.Content

    # Strip UTF-8 BOM if present, then trim outer whitespace
    $clean = $raw -replace "^\uFEFF", ""
    $clean = $clean.Trim()

    # Parse XML robustly
    $xml = New-Object System.Xml.XmlDocument
    $xml.PreserveWhitespace = $false
    $xml.LoadXml($clean)

    $packages = @{}

    # ItemGroup can appear multiple times; PackageReference may be null/empty
    foreach ($group in $xml.Project.ItemGroup) {
        if (-not $group.PackageReference) { continue }

        foreach ($pkg in $group.PackageReference) {
            $include = $pkg.Include
            $version = $pkg.Version

            if ([string]::IsNullOrWhiteSpace($include)) { continue }
            if ([string]::IsNullOrWhiteSpace($version)) { continue }

            $packages[$include] = $version
        }
    }

    Write-Host "Found $($packages.Count) package(s) in csproj."
    return $packages
}

function Get-LatestOcarambaTag {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ApiUrl
    )

    Write-Host "Fetching latest Ocaramba tag from $ApiUrl ..."
    $tags = Invoke-RestMethod -Uri $ApiUrl -Headers @{ "User-Agent" = "PowerShell" }

    if (-not $tags -or $tags.Count -eq 0) {
        throw "No tags returned from $ApiUrl"
    }

    $latest = $tags[0].name
    Write-Host "Latest Ocaramba tag: $latest"
    return $latest
}

function Emit-Output {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [string]$Value
    )

    # GitHub Actions compatible output
    Write-Host " → Output: $Name=$Value"
    Add-Content -Path $OutputFile -Value "$Name=$Value"
}

# ------------------------------------------------------------
# EXECUTION
# ------------------------------------------------------------

Write-Host "=== Ocaramba version sync - start ==="

# 1. Get package versions from csproj
$pkg = Get-PackageVersionsFromCsproj -Url $csprojUrl

# 2. Get latest Ocaramba tag
$ocarambaVersion = Get-LatestOcarambaTag -ApiUrl $repoApiTags

# 3. Mapping between csproj package names and GitHub Actions output names
#    NOTE: Some of these may not exist in the csproj anymore.
$map = @{
    "Selenium.WebDriver"                = "SeleniumWebDriverVersion"
    "Selenium.Support"                  = "SeleniumSupportVersion"
    "Selenium.WebDriver.ChromeDriver"   = "SeleniumWebdriverChromeDriverVersion"
    "Selenium.WebDriver.GeckoDriver"    = "SeleniumWebDriverGeckoDriverVersion"
    "Selenium.WebDriver.IEDriver"       = "SeleniumWebDriverIEDriverVersion"
    "Selenium.WebDriver.MSEdgeDriver"   = "SeleniumWebDriverMSEdgeDriverVersion"

    "NUnit"                             = "NUnitVersion"
    "NUnit3TestAdapter"                 = "NUnit3TestAdapterVersion"

    "Microsoft.NET.Test.Sdk"            = "MicrosoftNetTestSdkVersion"
    "MSTest.TestAdapter"                = "MSTestTestAdapterVersion"
    "MSTest.TestFramework"              = "MSTestTestFrameworkVersion"

    "NPOI"                              = "NPOIVersion"
    "NLog"                              = "NLogVersion"

    "System.Text.Json"                  = "SystemTextJsonVersion"
    "System.Text.Encodings.Web"         = "SystemTextEncodingsWebVersion"
}

Write-Host ""
Write-Host "Emitting package versions as GitHub Actions outputs..."

foreach ($csprojPackageName in $map.Keys) {
    $outputName = $map[$csprojPackageName]

    if ($pkg.ContainsKey($csprojPackageName)) {
        $version = $pkg[$csprojPackageName]
        Emit-Output -Name $outputName -Value $version
    }
    else {
        Write-Warning "Package '$csprojPackageName' not found in csproj. Output '$outputName' will NOT be set."
    }
}

# 4. Emit OcarambaVersion (from tags)
Emit-Output -Name "OcarambaVersion" -Value $ocarambaVersion

Write-Host ""
Write-Host "=== Ocaramba version sync - done ==="
