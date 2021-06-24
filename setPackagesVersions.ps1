$regex3='(\d+\.\d+\.\d+)'
$regex4='(\d+\.\d+\.\d+\.\d+)'

$aArray="Appveyor\.TestLogger-version\`$`" Value=`"$regex3",
"Microsoft\.NET\.Test\.Sdk-version\`$`" Value=`"$regex3", 
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

$bArray="Appveyor.TestLogger-version`$`" Value=`"$env:APPVEYORTESTLOGGERVERSION",
"Microsoft.NET.Test.Sdk-version`$`" Value=`"$env:MICROSOFTNETTESTSDKVERSION", 
"Ocaramba-version`$`" Value=`"$env:OCARAMBAVERSION","NPOI-version`$`" Value=`"$env:NPOIVERSION",
"Selenium.WebDriver.ChromeDriver-version`$`" Value=`"$env:SELENIUMWEBDRIVERCHROMEDRIVERVERSION",
"MSTest.TestAdapter-version`$`" Value=`"$env:MSTESTTESTADAPTERVERSION",
"MSTest.TestFramework-version`$`" Value=`"$env:MSTESTTESTFRAMEWORKVERSION",
"Selenium.WebDriver.GeckoDriver-version`$`" Value=`"$env:SELENIUMWEBDRIVERGECKODRIVERVERSION",
"Selenium.WebDriver.IEDriver-version`$`" Value=`"$env:SELENIUMWEBDRIVERIEDRIVERVERSION",
"NPOI-version`$`" Value=`"$env:NPOIVERSION",
"NUnit-version`$`" Value=`"$env:NUNITVERSION",
"NUnit3TestAdapter-version`$`" Value=`"$env:NUNIT3TESTADAPTERVERSION",
"Selenium.WebDriver-version`$`" Value=`"$env:SELENIUMWEBDRIVERVERSION",
"Selenium.Support-version`$`" Value=`"$env:SELENIUMSUPPORTVERSION",
"NLog-version`$`" Value=`"$env:NLOGVERSION"

Write-Host updating ./Ocaramba.ProjectExample.NUnit.NetCore/Ocaramba.NUnit.NC.vstemplate,`n /Ocaramba.ProjectExample.NUnit.NetFramework/Ocaramba.NUnit.NF.vstemplate,`n `
./Ocaramba.ProjectExample.MsTest.NetFramework/Ocaramba.MsTest.NF.vstemplate,`n ./Ocaramba.ProjectExample.MsTest.NetCore/Ocaramba.MsTest.NC.vstemplate

For ($i=0; $i -lt $aArray.length; $i++) {

Write-Host $bArray[$i] 

	((Get-Content -path ./Ocaramba.ProjectExample.NUnit.NetCore/Ocaramba.NUnit.NC.vstemplate -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.NUnit.NetCore/Ocaramba.NUnit.NC.vstemplate
	((Get-Content -path ./Ocaramba.ProjectExample.NUnit.NetFramework/Ocaramba.NUnit.NF.vstemplate -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.NUnit.NetFramework/Ocaramba.NUnit.NF.vstemplate
	((Get-Content -path ./Ocaramba.ProjectExample.MsTest.NetFramework/Ocaramba.MsTest.NF.vstemplate -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.MsTest.NetFramework/Ocaramba.MsTest.NF.vstemplate
	((Get-Content -path ./Ocaramba.ProjectExample.MsTest.NetCore/Ocaramba.MsTest.NC.vstemplate -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.MsTest.NetCore/Ocaramba.MsTest.NC.vstemplate
  }