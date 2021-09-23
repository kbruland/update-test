# Software install Script
#
# Applications to install:
#
# Foxit Reader Enterprise Packaging (requires registration)
# https://kb.foxitsoftware.com/hc/en-us/articles/360040658811-Where-to-download-Foxit-Reader-with-Enterprise-Packaging-MSI-
# 
# Notepad++
# https://notepad-plus-plus.org/downloads/v7.8.8/
# See comments on creating a custom setting to disable auto update message
# https://community.notepad-plus-plus.org/post/38160

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion

#region Visual Studio Professional with Data Tools optional workload addition
try {
    Start-Process -filepath 'c:\temp\vs_professional__1787135314.1631642858.exe' -Wait -ErrorAction Stop -ArgumentList '--add Microsoft.VisualStudio.Component.SQL.SSDT --quiet --norestart --wait'
    if (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\devenv.exe") {
        Write-Log "Visual Studio has been installed"
    }
    else {
        write-log "Error locating the Visual Studio executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Visual Studio: $ErrorMessage"
}
#endregion

#region SSIS Integration Services for Visual Studio Data Tools Extension
try {
    Start-Process -filepath 'c:\temp\Microsoft.DataTools.IntegrationServices.exe' -Wait -ErrorAction Stop -ArgumentList '/quiet /norestart'
    # TODO: Put the correct path into the line below once we know it after the first successful install...
    if (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\devenv.exe") {
        Write-Log "SSIS Integration Services has been installed"
    }
    else {
        write-log "Error locating the SSIS Integration Services executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing SSIS Integration Services: $ErrorMessage"
}
#endregion

#region SQL Server Management Studio (SSMS)
try {
    Start-Process -filepath 'c:\temp\SSMS-Setup-ENU.exe' -Wait -ErrorAction Stop -ArgumentList '/quiet /norestart'
    if (Test-Path "C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\Ssms.exe") {
        Write-Log "SQL Server Management Studio (SSMS) has been installed"
    }
    else {
        write-log "Error locating the SQL Server Management Studio (SSMS) executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Visual Studio: $ErrorMessage"
}
#endregion

# Redgate SQL Tools 
try {
    Start-Process -filepath 'c:\temp\SQLToolbelt.exe' -Wait -ErrorAction Stop -ArgumentList '/IAgreeToTheEula'
    if (Test-Path "C:\Program Files (x86)\Red Gate\SQL Compare 14\RedGate.SQLCompare.UI.exe") {
        Write-Log "Redgate SQL Tools  has been installed"
    }
    else {
        write-log "Error locating the Redgate SQL Tools executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Visual Studio: $ErrorMessage"
}
#endregion

# JDK Version 8 Update 301
try {
    Start-Process -filepath 'c:\temp\jdk-8u301-windows-x64.exe' -Wait -ErrorAction Stop -ArgumentList ' /s REBOOT=Suppress'
    if (Test-Path "C:\Program Files\Java\jdk1.8.0_301\bin\java.exe") {
        Write-Log "JDK Version 8 Update 301 has been installed"
    }
    else {
        write-log "Error locating the JDK Version 8 Update 301 executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Visual Studio: $ErrorMessage"
}
#endregion

# JDK Version 11 Update 12
try {
    Start-Process -filepath 'c:\temp\jdk-11.0.12_windows-x64_bin.exe' -Wait -ErrorAction Stop -ArgumentList '/s'
    if (Test-Path "C:\Program Files\Java\jdk-11.0.12\bin\java.exe") {
        Write-Log "JDK Version 11 Update 12 has been installed"
    }
    else {
        write-log "Error locating the JDK Version 11 Update 12 executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Visual Studio: $ErrorMessage"
}
#endregion

#region Adobe Reader
# try {
#     Start-Process -filepath 'c:\temp\AcroRdrDC2100720091_en_US.exe ' -Wait -ErrorAction Stop -ArgumentList '/sAll /rs /msi EULA_ACCEPT=YES'
#     if (Test-Path "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe") {
#         Write-Log "Adobe Reader has been installed"
#     }
#     else {
#         write-log "Error locating the Adobe Reader executable"
#     }
# }
# catch {
#     $ErrorMessage = $_.Exception.message
#     write-log "Error installing Adobe Reader: $ErrorMessage"
# }
#endregion

#region Foxit Reader
# try {
#     Start-Process -filepath msiexec.exe -Wait -ErrorAction Stop -ArgumentList '/i', 'c:\temp\FoxitReader101_enu_Setup.msi', '/quiet', 'ADDLOCAL="FX_PDFVIEWER"'
#     if (Test-Path "C:\Program Files (x86)\Foxit Software\Foxit Reader\FoxitReader.exe") {
#         Write-Log "Foxit Reader has been installed"
#     }
#     else {
#         write-log "Error locating the Foxit Reader executable"
#     }
# }
# catch {
#     $ErrorMessage = $_.Exception.message
#     write-log "Error installing Foxit Reader: $ErrorMessage"
# }
#endregion

#region Notepad++
# try {
#     Start-Process -filepath 'c:\temp\npp.7.8.8.Installer.x64.exe' -Wait -ErrorAction Stop -ArgumentList '/S'
#     Copy-Item 'C:\temp\config.model.xml' 'C:\Program Files\Notepad++'
#     Rename-Item 'C:\Program Files\Notepad++\updater' 'C:\Program Files\Notepad++\updaterOld'
#     if (Test-Path "C:\Program Files\Notepad++\notepad++.exe") {
#         Write-Log "Notepad++ has been installed"
#     }
#     else {
#         write-log "Error locating the Notepad++ executable"
#     }
# }
# catch {
#     $ErrorMessage = $_.Exception.message
#     write-log "Error installing Notepad++: $ErrorMessage"
# }
#endregion

#region Sysprep Fix
# Fix for first login delays due to Windows Module Installer
# try {
#     ((Get-Content -path C:\DeprovisioningScript.ps1 -Raw) -replace 'Sysprep.exe /oobe /generalize /quiet /quit', 'Sysprep.exe /oobe /generalize /quit /mode:vm' ) | Set-Content -Path C:\DeprovisioningScript.ps1
#     write-log "Sysprep Mode:VM fix applied"
# }
# catch {
#     $ErrorMessage = $_.Exception.message
#     write-log "Error updating script: $ErrorMessage"
# }
#endregion

#region Time Zone Redirection
# $Name = "fEnableTimeZoneRedirection"
# $value = "1"
# # Add Registry value
# try {
#     New-ItemProperty -ErrorAction Stop -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name $name -Value $value -PropertyType DWORD -Force
#     if ((Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services").PSObject.Properties.Name -contains $name) {
#         Write-log "Added time zone redirection registry key"
#     }
#     else {
#         write-log "Error locating the Teams registry key"
#     }
# }
# catch {
#     $ErrorMessage = $_.Exception.message
#     write-log "Error adding teams registry KEY: $ErrorMessage"
# }
#endregion