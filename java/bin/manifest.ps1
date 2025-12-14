# Desc:Displays the contents of a MANIFEST.MF inside a jar file
# Define command line parameters
param (
    [string]$jar = $( Read-Host "JAR file" )
)

$thisScript = $MyInvocation.MyCommand.Name

# https://devblogs.microsoft.com/powershell-community/borrowing-a-built-in-powershell-command-to-create-a-temporary-folder/
Function New-TemporaryFolder {
    # Make a new folder based upon a TempFileName. $Env:temp does not always work in Linux
    $sysTempFolder = [System.IO.Path]::GetTempPath()
    $tempFolder="$sysTempFolder$thisScript-$([convert]::tostring((get-random 65535),16).padleft(4,'0')).tmp"
    New-Item -ItemType Directory -Path $tempFolder
}

# Extract the ZIP file to another temporary folder
$tempExtractFolder = New-TemporaryFolder
Expand-Archive -Path $jar -DestinationPath $tempExtractFolder

# Read the contents of the extracted files (example with Get-ChildItem)
Get-Content -Path $tempExtractFolder/META-INF/MANIFEST.MF

# Clean up the temporary files
Remove-Item -Path $tempExtractFolder -Recurse -Force