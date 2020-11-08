' Removes Fake CRs
' Author: Bill Chatfield
' Untested, work-in-progress


function removeFakeCRsFromLine(oneLine as String) as String
    dim prevChar as String
    dim c as String
    dim correctedLine as String
    dim i as Integer

    correctedLine = ""
    prevChar = left(oneLine, 1)
    for i = 2 to len(oneLine)
        c = mid(oneLine, i, 1)
        if not (prevChar = "^" and c = "M") then
            correctedLine = correctedLine + prevChar
        end if
        prevChar = c
    next i
    if right(oneLine, 1) <> "^M" then
        correctedLine = correctedLine + prevChar
    end if
    removeFakeCRsFromLine = correctedLine
end function

sub removeFakeCRs(fileName as String)
    dim oneLine as String
    open fileName for input as #1
    do while not eof(1)
        line input #1, oneLine
        oneLine = removeFakeCRsFromLine(oneLine)
        print oneLine
    loop
    close #1
end sub

''''''''''''''''
'
' Main Program
'
''''''''''''''''
dim fileName as String
input "File";fileName
removeFakeCRs(fileName)
end

