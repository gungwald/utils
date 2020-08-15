
Function joinArguments(args, startIndex)
    Dim joinedArgs
    joinedArgs = args(startIndex)
    For i = startIndex + 1 to args.Count - 1
        joinedArgs = joinedArgs & " " & args(i)
    Next
    joinArguments = joinedArgs
End Function

title = "Title"
message = "Message"

if WScript.Arguments.Count > 0 then
    title = WScript.Arguments(0)
end if

if WScript.Arguments.Count > 1 then
    message = WScript.Arguments(1)
end if

MsgBox message, vbCritical, title

