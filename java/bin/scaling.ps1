

To force all java executables to have "properties > compatibility > dpi scaling mode" set to "System", in an administrator powershell (win-x, a), run:

$javaexes = (Get-ChildItem -path "$env:ProgramFiles\Java","${env:ProgramFiles(x86)}\java" -filter java?.exe -recurse  | Where-Object {$_.Name -match "java(|w).exe"} ).fullname

$javaexes | foreach {REG ADD "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"  /V $_ /T REG_SZ /D "~ DPIUNAWARE" /F}

to undo:

$javaexes | foreach {REG delete "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"  /V $_ /f}

Instead of HKCU you could use HKLM, but then you cannot change the dpi-scaling setting manually anymore in the properties > compatibility dialog of the java*.exe files.

