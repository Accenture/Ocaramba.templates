$regex='(\d+\.\d+\.\d+|\.\d+)'

Write-Host templateVersion $env:TEMPLATEVERSION, updating ./Ocaramba.Templates.VSIX/source.extension.vsixmanifest

((Get-Content -path ./Ocaramba.Templates.VSIX/source.extension.vsixmanifest -Raw) -replace 'Version="\d\.\d" Language','Version="$env:TEMPLATEVERSION" Language') `
| Set-Content -Path ./Ocaramba.Templates.VSIX/source.extension.vsixmanifest

$aArray="Appveyor\.TestLogger-version\`$`" Value=`"$regex","Microsoft\.NET\.Test\.Sdk-version\`$`" Value=`"$regex", 
"Ocaramba-version\`$`" Value=`"$regex", "NPOI-version\`$`" Value=`"$regex", "Selenium\.WebDriver\.ChromeDriver-version\`$`" Value=`"$regex"

$bArray="Appveyor.TestLogger-version`$`" Value=`"$env:APPVEYORTESTLOGGERVERSION","Microsoft.NET.Test.Sdk-version`$`" Value=`"$env:MICROSOFTNETTESTSDKVERSION", 
"Ocaramba-version`$`" Value=`"$env:OCARAMBAVERSION","NPOI-version`$`" Value=`"$env:NPOIVERSION","Selenium.WebDriver.ChromeDriver-version`$`" Value=`"$env:SELENIUMWEBDRIVERCHROMEDRIVERVERSION"

Write-Host updating ./Ocaramba.ProjectExample.NUnit.NetCore/Ocaramba.NUnit.NC.vstemplate,`n /Ocaramba.ProjectExample.NUnit.NetFramework/Ocaramba.NUnit.NF.vstemplate,`n `
./Ocaramba.ProjectExample.MsTest.NetFramework/Ocaramba.MsTest.NF.vstemplate,`n ./Ocaramba.ProjectExample.MsTest.NetCore/Ocaramba.MsTest.NC.vstemplate

For ($i=0; $i -lt $aArray.length; $i++) {

Write-Host $bArray[$i] 

	((Get-Content -path ./Ocaramba.ProjectExample.NUnit.NetCore/Ocaramba.NUnit.NC.vstemplate -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.NUnit.NetCore/Ocaramba.NUnit.NC.vstemplate
	((Get-Content -path ./Ocaramba.ProjectExample.NUnit.NetFramework/Ocaramba.NUnit.NF.vstemplate -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.NUnit.NetFramework/Ocaramba.NUnit.NF.vstemplate
	((Get-Content -path ./Ocaramba.ProjectExample.MsTest.NetFramework/Ocaramba.MsTest.NF.vstemplate -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.MsTest.NetFramework/Ocaramba.MsTest.NF.vstemplate
	((Get-Content -path ./Ocaramba.ProjectExample.MsTest.NetCore/Ocaramba.MsTest.NC.vstemplate -Raw) -replace $aArray[$i],$bArray[$i]) | Set-Content -Path ./Ocaramba.ProjectExample.MsTest.NetCore/Ocaramba.MsTest.NC.vstemplate
  }