<#
.SYNOPSIS
  Extracts package versions from all Ocaramba csproj files and exposes them
  as GitHub Actions outputs (GITHUB_OUTPUT).

.DESCRIPTION
  - Downloads 3 csproj files:
        Ocaramba/Ocaramba.csproj
        Ocaramba.Tests.NUnit/Ocaramba.Tests.NUnit.csproj
        Ocaramba.Tests.MsTest/Ocaramba.Tests.MsTest.csproj
  - Handles UTF-8 BOM and whitespace safely
  - Parses <PackageReference> items into a merged dictionary
  - Fetches latest Ocaramba tag from GitHub
  - Emits mapped variables as GitHub Actions outputs
#>

$ErrorActionPreference = "Stop"

# ------------------------------------------------------------
# CONFIG
# ------------------------------------------------------------

$csprojUrls = @(
    "https://raw.githubusercontent.com/Accenture/Ocaramba/master/Ocaramba/Ocaramba.csproj",
    "https://raw.githubusercontent.com/Accenture/Ocaramba/master/Ocaramba.Tests.NUnit/Ocaramba.Tests.NUnit.csproj",
    "https://raw.githubusercontent.com/Accenture/Ocaramba/master/Ocaramba.Tests.MsTest/Ocaramba.Tests.MsTest.csproj"
)

$repoApiTags = "https://api.github.com/repos/Accenture/Ocaramba/tags"

$OutputFile = $env:GITHUB_OUTPUT
if (-not $OutputFile) {
    Write-Warning "GITHUB_OUTPUT not set. Using ./local_output.txt (local run mode)."
    $OutputFile = "./local_output.txt"
}

# ------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------

function Load-Csproj {
    param([string]$Url)

    Write-Host "Downloading $Url ..."
    $raw = Invoke-WebRequest -Uri $Url -UseBasicParsing | Select-Object -ExpandProperty Content

    # Remove BOM + trim
    $clean = $raw -replace "^\uFEFF", ""
    $clean = $clean.Trim()

    # Parse XML
    $xml = New-Object System.Xml.XmlDocument
    $xml.PreserveWhitespace = $false
    $xml.LoadXml($clean)

    return $xml
}

function Extract-Packages {
    param([xml]$Xml)

    $dict = @{}

    foreach ($group in $Xml.Project.ItemGroup) {
        if (-not $group.PackageReference) { continue }

        foreach ($pkg in $group.PackageReference) {
            $include = $pkg.Include
            $version = $pkg.Version

            if ($include -and $version) {
                $dict[$include] = $version
            }
        }
    }

    return $dict
}

function Get-LatestOcarambaTag {
    param([string]$ApiUrl)

    Write-Host "Fetching latest Ocaramba tag..."
    $tags = Invoke-RestMethod -Uri $ApiUrl -Headers @{ "User-Agent" = "PowerShell" }

    if (-not $tags -or $tags.Count -eq 0) {
        throw "No tags returned from GitHub API"
    }

    return $tags[0].name
}

function Emit-Output {
    param([string]$Name, [string]$Value)

    Write-Host " → $Name=$Value"
    Add-Content -Path $OutputFile -Value "$Name=$Value"
}

# ------------------------------------------------------------
# EXECUTION
# ------------------------------------------------------------

Write-Host "=== Ocaramba version sync (merged csproj mode) ==="

$allPackages = @{}

foreach ($url in $csprojUrls) {
    $xml = Load-Csproj -Url $url
    $pkgs = Extract-Packages -Xml $xml

    foreach ($k in $pkgs.Keys) {
        # Last writer wins — NUnit/MsTest override base if needed
        $allPackages[$k] = $pkgs[$k]
    }
}

Write-Host "`nMerged package list:"
$allPackages.GetEnumerator() | Sort-Object Name | Format-Table -AutoSize

# ------------------------------------------------------------
# MAPPING TO YOUR EXISTING VARIABLE NAMES
# ------------------------------------------------------------

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

Write-Host "`nEmitting mapped GitHub Actions outputs..."

foreach ($pkgName in $map.Keys) {
    $outputName = $map[$pkgName]

    if ($allPackages.ContainsKey($pkgName)) {
        Emit-Output -Name $outputName -Value $allPackages[$pkgName]
    }
    else {
        Write-Warning "Package '$pkgName' not found in any csproj. Output '$outputName' will NOT be set."
    }
}

# Emit latest Ocaramba version
$ocarambaVersion = Get-LatestOcarambaTag -ApiUrl $repoApiTags
Emit-Output -Name "OcarambaVersion" -Value $ocarambaVersion

Write-Host "`n✅ DONE — extracted & merged versions from all 3 csproj files."
