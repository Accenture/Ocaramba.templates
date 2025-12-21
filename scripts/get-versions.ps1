$ErrorActionPreference = "Stop"

# ------------------------------------------------------------
# CONFIG
# ------------------------------------------------------------
$csprojUrl = "https://raw.githubusercontent.com/Accenture/Ocaramba/master/Ocaramba/Ocaramba.csproj"
$repoApiTags = "https://api.github.com/repos/Accenture/Ocaramba/tags"

# GitHub Actions output file
$OutputFile = $env:GITHUB_OUTPUT
if (-not $OutputFile) {
    Write-Host "GITHUB_OUTPUT not set. Running locally?"
    $OutputFile = "./local_output.txt"
}

# ------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------

function Get-PackageVersionsFromCsproj {
    param([string]$Url)

    Write-Host "Downloading csproj from $Url ..."
    $xml = [xml](Invoke-WebRequest -Uri $Url -UseBasicParsing).Content

    $packages = @{}
    foreach ($pkg in $xml.Project.ItemGroup.PackageReference) {
        $packages[$pkg.Include] = $pkg.Version
    }
    return $packages
}

function Get-LatestOcarambaTag {
    param([string]$ApiUrl)

    Write-Host "Fetching latest Ocaramba tag..."
    $tags = Invoke-RestMethod -Uri $ApiUrl -Headers @{ "User-Agent" = "PowerShell" }
    return $tags[0].name
}

function Emit-Output {
    param(
        [string]$Name,
        [string]$Value
    )
    Write-Host " → $Name=$Value"
    Add-Content -Path $OutputFile -Value "$Name=$Value"
}

# ------------------------------------------------------------
# EXECUTION
# ------------------------------------------------------------

Write-Host "Extracting package versions..."
$pkg = Get-PackageVersionsFromCsproj -Url $csprojUrl

Write-Host "Getting latest Ocaramba version..."
$ocarambaVersion = Get-LatestOcarambaTag -ApiUrl $repoApiTags

# Mapping between csproj package names and GitHub Actions output names
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

Write-Host "`nEmitting GitHub Actions outputs..."

foreach ($k in $map.Keys) {
    if ($pkg.ContainsKey($k)) {
        Emit-Output -Name $map[$k] -Value $pkg[$k]
    } else {
        Write-Warning "Package $k not found in csproj!"
    }
}

Emit-Output -Name "OcarambaVersion" -Value $ocarambaVersion

Write-Host "`n✅ DONE — GitHub Actions outputs generated."
