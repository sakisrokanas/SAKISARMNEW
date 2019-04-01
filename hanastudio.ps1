param (
    
        [string]$baseUri
    )
    
    #Get the bits for the HANA installation and copy them to C:\SAPbits\SAP_HANA_STUDIO\
    $hanadest = "C:\SapBits"
    $sapcarUri = $baseUri + "/SapBits/SAP_HANA_STUDIO/SAPCAR.EXE"
    $hanastudioUri = $baseUri + "/SapBits/SAP_HANA_STUDIO/IMC_STUDIO2_212_2-80000323.SAR" 
    $jreUri = $baseUri + "/SapBits/SAP_HANA_STUDIO/jdk-12_windows-x64_bin.exe"
    $puttyUri = "https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe"
    #7zUri = "http://www.7-zip.org/a/7z1701-x64.msi"
    $sapcardest = "C:\SapBits\SAP_HANA_STUDIO\sapcar.exe"
    $hanastudiodest = "C:\SapBits\SAP_HANA_STUDIO\IMC_STUDIO2_212_2-80000323.SAR"
    $jredest = "C:\Program Files\jdk-12_windows-x64_bin.zip"
    $puttydest = "C:\Users\testuser\Desktop\putty.exe"
    #7zdest = "C:\Program Files\7z.msi"
    $jrepath = "C:\Program Files"
    $hanapath = "C:\SapBits\SAP_HANA_STUDIO"
    if((test-path $hanadest) -eq $false)
    {
        New-Item -Path $hanadest -ItemType directory
        New-item -Path $hanapath -itemtype directory
    }
    write-host "downloading files"
    Invoke-WebRequest $sapcarUri -OutFile $sapcardest
    Invoke-WebRequest $hanastudioUri -OutFile $hanastudiodest
    Invoke-WebRequest $jreUri -OutFile $jredest
    #Invoke-WebRequest $7zUri -OutFile $7zdest
    Invoke-WebRequest $puttyUri -OutFile $puttydest
    
    #write-host "installing 7zip and extracting JAVA"
    write-host "Installing JAVA"
    Expand-Archive -Path $jredest -DestinationPath $jrepath
       
    
    write-host "extracting and installing HANA Studio"
    .\sapcar.exe -xfv IMC_STUDIO2_212_2-80000323.SAR
    
    set PATH=%PATH%C:\Program Files\jdk-12\bin;
    set HDB_INSTALLER_TRACE_FILE=C:\Users\testuser\Documents\hdbinst.log
    cd C:\SAPbits\SAP_HANA_STUDIO\SAP_HANA_STUDIO\
    .\C:\SAPbits\SAP_HANA_STUDIO\SAP_HANA_STUDIO\hdbinst.exe -a C:\SAPbits\SAP_HANA_STUDIO\SAP_HANA_STUDIO\studio -b --path="C:\Program Files\sap\hdbstudio"
