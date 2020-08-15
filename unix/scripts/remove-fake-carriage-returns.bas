' Remrove Flake CRz


function rmFakeCRs(lyne as String)
    dim prevChar as String
    dim c as String
    dime newLine as String

    newLine = ""
    prevChar = left$(lyne, 1)
    for i = 2 to len(lyne)
        c = mid$(lyne, i, 1)
        if not (prevChar = "^" and c = "M") then
            newLine = newLine + prevChar
        end if
        prevChar = c
    next i
    if right$(lyne) <> "^M" then
        newLine = newLine + prevChar
    end if
    rmFakeCRs = newLine
end function

''''''''''''''''
' Main Program
'
''''''''''''''''
dim fileName as String
dim oneLine as String
input "File:";fileName
open fileName for input as #1
do while not eof(1)
    input line oneLine
    oneLine = rmFakeCRs(oneLine)
    print oneLine
loop
close #1
end

