:: Usage: call dirname <filename> <resultvariable>
setlocal EnableDelayedExpansion
set parentDir=%~dp1
:: Strip trailing backslash.
set parentDir=%_dir:~0,-1%
:: Assign result to second argument.
endlocal & set %2=%parentDir%
