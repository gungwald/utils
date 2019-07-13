10 REM
20 REM  Converts text files from UNIX to Windows format.
30 REM
33 LET CR$ = CHR$(13)
35 LET LF$ = CHR$(10)
40 INPUT "What file do you want to convert"; infile$
45 INPUT "What name do you want to use for the converted file"; outfile$
50 OPEN "R", #1, infile$, 1
52 OPEN "R", #2, outfile$, 1
55 FIELD #1, 1 AS cin$
57 FIELD #2, 1 AS cout$
58 LET outbytecount = 1
60 DO WHILE NOT EOF(1)
70     GET #1
72     IF cin$ = LF$ THEN
73         cout$ = CR$
74         PUT #2, outbytecount
75         LET outbytecount = outbytecount + 1
76     END IF
77     LET cout$ = cin$
80     PUT #2, outbytecount
85     LET outbytecount = outbytecount + 1
90 LOOP
100 CLOSE #2
110 CLOSE #1
120 SYSTEM
130 END
