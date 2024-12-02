$OcarambaVersion='4.2.0'
  
$SeleniumWebDriverVersion='4.4.0'
$SeleniumSupportVersion= '4.4.0'
  
$SeleniumWebdriverChromeDriverVersion='131.0.6778.8500'
$SeleniumWebDriverGeckoDriverVersion= '0.35.0'
$SeleniumWebDriverIEDriverVersion= '4.14.0'
 
$NUnitVersion= '3.13.3'
$NUnit3TestAdapterVersion= '4.6.0'

$MicrosoftNetTestSdkVersion= '17.12.0'
$MSTestTestAdapterVersion= '2.2.10'
$MSTestTestFrameworkVersion= '2.2.10'

$NPOIVersion= '2.7.2'
$NLogVersion= '5.3.4'

$regex3='(\d+\.\d+\.\d+)'
$regex4='(\d+\.\d+\.\d+\.\d+)'

$aArray="Microsoft\.NET\.Test\.Sdk-version\`$`" Value=`"$regex3", 
"Ocaramba-version\`$`" Value=`"$regex3", "NPOI-version\`$`" Value=`"$regex3",
"Selenium\.WebDriver\.ChromeDriver-version\`$`" Value=`"$regex4",
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
	((Get-Content -path ./Ocaramba.ProjectExample.MsTest.NetFramework/packages.config -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.MsTest.NetFramework/packages.config
  }
