@for %%p in ("%PATH:;=" "%") do @if "%%~p"=="" ( echo. ) else echo %%~p
