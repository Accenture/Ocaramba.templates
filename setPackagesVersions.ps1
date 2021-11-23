$OcarambaVersion=$env:OcarambaVersion
  
$SeleniumWebDriverVersion=$env:SeleniumWebDriverVersion
$SeleniumSupportVersion= $env:SeleniumSupportVersion
  
$SeleniumWebdriverChromeDriverVersion=$env:SeleniumWebdriverChromeDriverVersion
$SeleniumWebDriverGeckoDriverVersion= $env:SeleniumWebDriverGeckoDriverVersion
$SeleniumWebDriverIEDriverVersion= $env:SeleniumWebDriverIEDriverVersion
 
$NUnitVersion= $env:NUnitVersion
$NUnit3TestAdapterVersion= $env:NUnit3TestAdapterVersion

$MicrosoftNetTestSdkVersion= $env:MicrosoftNetTestSdkVersion
$MSTestTestAdapterVersion= $env:MSTestTestAdapterVersion
$MSTestTestFrameworkVersion= $env:MSTestTestFrameworkVersion

$NPOIVersion= $env:NPOIVersion
$NLogVersion= $env:NLogVersion

$regex3='(\d+\.\d+\.\d+)'
$regex4='(\d+\.\d+\.\d+\.\d+)'

$aArray="Microsoft\.NET\.Test\.Sdk-version\`$`" Value=`"$regex3", 
"Ocaramba-version\`$`" Value=`"$regex3", "NPOI-version\`$`" Value=`"$regex3",
"Selenium\.WebDriver\.ChromeDriver-version\`$`" Value=`"$regex3",
"MSTest\.TestAdapter-version\`$`" Value=`"$regex3",
"MSTest\.TestFramework-version\`$`" Value=`"$regex3",
"Selenium\.WebDriver\.GeckoDriver-version\`$`" Value=`"$regex3",
"Selenium\.WebDriver\.IEDriver-version\`$`" Value=`"$regex3",
"NPOI-version\`$`" Value=`"$regex3",
"NUnit-version\`$`" Value=`"$regex3",
"NUnit3TestAdapter-version\`$`" Value=`"$regex3",
"Selenium\.WebDriver-version\`$`" Value=`"$regex3",
"Selenium\.Support-version\`$`" Value=`"$regex3",
"NLog-version\`$`" Value=`"$regex3"

$bArray="Microsoft.NET.Test.Sdk-version`$`" Value=`"$MICROSOFTNETTESTSDKVERSION", 
"Ocaramba-version`$`" Value=`"$OCARAMBAVERSION","NPOI-version`$`" Value=`"$NPOIVERSION",
"Selenium.WebDriver.ChromeDriver-version`$`" Value=`"$SELENIUMWEBDRIVERCHROMEDRIVERVERSION",
"MSTest.TestAdapter-version`$`" Value=`"$MSTESTTESTADAPTERVERSION",
"MSTest.TestFramework-version`$`" Value=`"$MSTESTTESTFRAMEWORKVERSION",
"Selenium.WebDriver.GeckoDriver-version`$`" Value=`"$SELENIUMWEBDRIVERGECKODRIVERVERSION",
"Selenium.WebDriver.IEDriver-version`$`" Value=`"$SELENIUMWEBDRIVERIEDRIVERVERSION",
"NPOI-version`$`" Value=`"$NPOIVERSION",
"NUnit-version`$`" Value=`"$NUNITVERSION",
"NUnit3TestAdapter-version`$`" Value=`"$NUNIT3TESTADAPTERVERSION",
"Selenium.WebDriver-version`$`" Value=`"$SELENIUMWEBDRIVERVERSION",
"Selenium.Support-version`$`" Value=`"$SELENIUMSUPPORTVERSION",
"NLog-version`$`" Value=`"$NLOGVERSION"


For ($i=0; $i -lt $aArray.length; $i++) {
	echo $bArray[$i]
	$valueNumber=$bArray[$i] -split 'Value'
	if(([regex]::Matches($valueNumber[1], "\." )).count -eq 3){

	$aArray[$i]= $aArray[$i].replace('Value="(`(+\.\d+\.\d+)','Value="(`(+\.\d+\.\d+\.\d+)')
		}
	echo $aArray[$i]	
  }

Write-Host updating ./Ocaramba.ProjectExample.NUnit.NetCore/Ocaramba.NUnit.NC.vstemplate,`n /Ocaramba.ProjectExample.NUnit.NetFramework/Ocaramba.NUnit.NF.vstemplate,`n `
./Ocaramba.ProjectExample.MsTest.NetFramework/Ocaramba.MsTest.NF.vstemplate,`n ./Ocaramba.ProjectExample.MsTest.NetCore/Ocaramba.MsTest.NC.vstemplate

For ($i=0; $i -lt $aArray.length; $i++) {

Write-Host $bArray[$i] 

	((Get-Content -path ./Ocaramba.ProjectExample.NUnit.NetCore/Ocaramba.NUnit.NC.vstemplate -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.NUnit.NetCore/Ocaramba.NUnit.NC.vstemplate
	((Get-Content -path ./Ocaramba.ProjectExample.NUnit.NetFramework/Ocaramba.NUnit.NF.vstemplate -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.NUnit.NetFramework/Ocaramba.NUnit.NF.vstemplate
	((Get-Content -path ./Ocaramba.ProjectExample.MsTest.NetFramework/Ocaramba.MsTest.NF.vstemplate -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.MsTest.NetFramework/Ocaramba.MsTest.NF.vstemplate
	((Get-Content -path ./Ocaramba.ProjectExample.MsTest.NetCore/Ocaramba.MsTest.NC.vstemplate -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.MsTest.NetCore/Ocaramba.MsTest.NC.vstemplate
  }
