Rem
Rem     Splitpath implemented in BW-BASIC
Rem
Rem     Mid$ doesn't work in BW-BASIC so this program fails
Rem	Mid$ is apparently fixed in version 3.2
Rem	UNIX shebang doesn't work in 3.2 but is fixed in 3.3
Rem

DefInt i, j, s

Let path$ = Environ$("PATH")
Let separator$ = findSeparator$(path$)
Let result = split(path$, separator$)
End

Function findSeparator$(s$)
    If InStr(s$, ";") > 0 Then
        result$ = ";"
    ElseIf InStr(s$, ":") > 0 Then
        result$ = ":"
    Else
        result$ = ""
    End If
    findSeparator$ = result$ : Rem Must be the last line of Function
End Function

Function split(what$, splittor$)
    Let s = 1
    Let i = InStr(s, what$, splittor$)

    Do While i > 0
        Print Mid$(what$, s, i - s)
        Let s = i + 1
        Let i = InStr(s, what$, splittor$)
    Loop
    
    Rem Get the very last element, if there is one
    If s <= Len(what$) Then
       Print Mid$(what$, s)
    End If
    split = 1
End Function

