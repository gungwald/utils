rem
rem	Because other programs like WebSphere need port 443 and IIS refuses
rem	to relinquish it, even though https is not configured, this will
rem	change which port IIS binds to for the https protocol.
rem

cscript c:\inetpub\AdminScripts\adsutil.vbs set w3svc/1/securebindings ":10443:"

