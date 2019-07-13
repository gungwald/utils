" Vim syntax file
" Language:    Virtual Basic
" Maintainer:  Bill Chatfield <bill_chatfield@yahoo.com>
" Updated:     2019-01-14
"
" Description:
"
"	Based originally on the work done by Allan Kelly <Allan.Kelly@ed.ac.uk>
"	Updated by Mark Manning <markem@airmail.net>
"	Applied FreeBasic support to the already excellent support
"	for standard basic syntax (like QB).
"
"	First version based on Micro$soft QBASIC circa
"	1989, as documented in 'Learn BASIC Now' by
"	Halvorson&Rygmyr. Microsoft Press 1989.  This syntax file
"	not a complete implementation yet.  Send suggestions to
"	the maintainer.
"
"	Quit when a (custom) syntax file was already loaded (Taken from c.vim)
"
if exists("b:current_syntax")
  finish
endif
"
"	Be sure to turn on the "case ignore" since current versions
"	of virtualbasic support both upper as well as lowercase
"	letters. - MEM 10/1/2006
"
syn case ignore
"
"	This list of keywords is taken directly from the FreeBasic
"	user's guide as presented by the FreeBasic online site.
"
"syn keyword	virtualbasicArrays			ERASE LBOUND REDIM PRESERVE UBOUND 

"syn keyword	virtualbasicBitManipulation	BIT BITRESET BITSET HIBYTE HIWORD LOBYTE LOWORD SHL SHR 

"syn keyword	virtualbasicCompilerSwitches	DEFBYTE DEFDBL DEFINT DEFLNG DEFLNGINT DEFSHORT DEFSNG DEFSTR 
"syn keyword	virtualbasicCompilerSwitches	DEFUBYTE DEFUINT DEFULNGINT DEFUSHORT 
"syn match	virtualbasicCompilerSwitches	"\<option\s+\(BASE\|BYVAL\|DYNAMIC\|ESCAPE\|EXPLICIT\|NOKEYWORD\)\>"
"syn match	virtualbasicCompilerSwitches	"\<option\s+\(PRIVATE\|STATIC\)\>"

syn region	virtualbasicConditional		start="\son\s+" skip=".*" end="gosub"
syn region	virtualbasicConditional		start="\son\s+" skip=".*" end="goto"
"syn match	virtualbasicConditional		"\<select\s+case\>"
syn keyword	virtualbasicConditional		if then

"syn match	virtualbasicConsole		"\<open\s+\(CONS\|ERR\|PIPE\|SCRN\)\>"
syn keyword	virtualbasicConsole		HOME PRINT SPC TAB TEXT

syn keyword	virtualbasicDataTypes		DIM

"syn keyword	virtualbasicDateTime		DATE DATEADD DATEDIFF DATEPART DATESERIAL DATEVALUE DAY HOUR MINUTE
"syn keyword	virtualbasicDateTime		MONTH MONTHNAME NOW SECOND SETDATE SETTIME TIME TIMESERIAL TIMEVALUE
"syn keyword	virtualbasicDateTime		TIMER YEAR WEEKDAY WEEKDAYNAME

"syn keyword	virtualbasicDebug			ASSERT STOP

"syn keyword	virtualbasicErrorHandling		ERR ERL ERROR LOCAL RESUME
"syn match	virtualbasicErrorHandling		"\<resume\s+next\>"
syn match	virtualbasicErrorHandling		"\<on\s+error\>"

syn match	virtualbasicFiles			"\<get\s+#\>"
syn match	virtualbasicFiles			"\<input\s+#\>"
"syn match	virtualbasicFiles			"\<line\s+input\s+#\>"
syn match	virtualbasicFiles			"\<put\s+#\>"
syn keyword	virtualbasicFiles			BLOAD BSAVE INPUT
"syn keyword	virtualbasicFiles			RESET SEEK UNLOCK WRITE

"syn keyword	virtualbasicFunctions		ALIAS ANY BYREF BYVAL CALL CDECL CONSTRUCTOR DESTRUCTOR
"syn keyword	virtualbasicFunctions		DECLARE FUNCTION LIB OVERLOAD PASCAL STATIC SUB STDCALL
"syn keyword	virtualbasicFunctions		VA_ARG VA_FIRST VA_NEXT

"syn match	virtualbasicGraphics		"\<palette\s+get\>"
syn keyword	virtualbasicGraphics		COLOR HCOLOR DRAW HPLOT PLOT HGR HGR2
"syn keyword	virtualbasicGraphics		PRESET PSET PUT RGB RGBA SCREEN SCREENCOPY SCREENINFO SCREENLIST
"syn keyword	virtualbasicGraphics		SCREENLOCK SCREENPTR SCREENRES SCREENSET SCREENSYNC SCREENUNLOCK
"syn keyword	virtualbasicGraphics		TRANS USING VIEW WINDOW

"syn match	virtualbasicHardware		"\<open\s+com\>"
"syn keyword	virtualbasicHardware		INP OUT WAIT LPT LPOS LPRINT

syn keyword	virtualbasicLogical		AND OR NOT XOR

syn keyword	virtualbasicMath			ABS ACOS ASIN ATAN2 ATN COS EXP FIX INT LOG MOD
syn keyword	virtualbasicMath			RND SGN SIN SQR TAN

"syn keyword	virtualbasicMemory			ALLOCATE CALLOCATE CLEAR DEALLOCATE FIELD FRE PEEK POKE REALLOCATE
syn keyword	virtualbasicMemory			FRE PEEK POKE

syn keyword	virtualbasicMisc			DATA LET TO READ RESTORE

syn keyword	virtualbasicModularizing		CHAIN 
syn keyword	virtualbasicModularizing		SECTION CLOSESECTION 
"syn keyword	virtualbasicModularizing		PRIVATE PUBLIC

"syn keyword	virtualbasicMultithreading		MUTEXCREATE MUTEXDESTROY MUTEXLOCK MUTEXUNLOCK THREADCREATE THREADWAIT

"syn keyword	virtualbasicShell			CHDIR DIR COMMAND ENVIRON EXEC EXEPATH KILL NAME MKDIR RMDIR RUN

"syn keyword	virtualbasicEnviron		SHELL SYSTEM WINDOWTITLE POINTERS

syn keyword	virtualbasicLoops			FOR STEP next

"syn match	virtualbasicInclude		"\<#\s*\(inclib\|include\)\>"
"syn match	virtualbasicInclude		"\<\$\s*include\>"

"syn keyword	virtualbasicPointer		PROCPTR PTR SADD STRPTR VARPTR

"syn keyword	virtualbasicPredefined		__DATE__ __FB_DOS__ __FB_LINUX__ __FB_MAIN__ __FB_MIN_VERSION__
"syn keyword	virtualbasicPredefined		__FB_SIGNATURE__ __FB_VERSION__ __FB_WIN32__ __FB_VER_MAJOR__
"syn keyword	virtualbasicPredefined		__FB_VER_MINOR__ __FB_VER_PATCH__ __FILE__ __FUNCTION__
"syn keyword	virtualbasicPredefined		__LINE__ __TIME__

"syn match	virtualbasicPreProcessor		"\<^#\s*\(define\|undef\)\>"
"syn match	virtualbasicPreProcessor		"\<^#\s*\(ifdef\|ifndef\|else\|elseif\|endif\|if\)\>"
"syn match	virtualbasicPreProcessor		"\<#\s*error\>"
"syn match	virtualbasicPreProcessor		"\<#\s*\(print\|dynamic\|static\)\>"
"syn keyword	virtualbasicPreProcessor		DEFINED ONCE

syn keyword	virtualbasicProgramFlow		END GOSUB GOTO
syn keyword	virtualbasicProgramFlow		RETURN

syn keyword	virtualbasicString			LEFT LEN MID RIGHT
syn keyword	virtualbasicString			ASC CHR
syn keyword	virtualbasicString			STR VAL

"syn keyword	virtualbasicTypeCasting		CAST CBYTE CDBL CINT CLNG CLNGINT CPTR CSHORT CSIGN CSNG
"syn keyword	virtualbasicTypeCasting		CUBYTE CUINT CULNGINT CUNSG CURDIR CUSHORT

"syn match	virtualbasicUserInput		"\<line\s+input\>"
"syn keyword	virtualbasicUserInput		GETJOYSTICK GETKEY GETMOUSE INKEY INPUT MULTIKEY SETMOUSE
"
"	Do the Basic variables names first.  This is because it
"	is the most inclusive of the tests.  Later on we change
"	this so the identifiers are split up into the various
"	types of identifiers like functions, basic commands and
"	such. MEM 9/9/2006
"
syn match	virtualbasicIdentifier		"\<[a-zA-Z_][a-zA-Z0-9_]*\>"
syn match	virtualbasicGenericFunction	"\<[a-zA-Z_][a-zA-Z0-9_]*\>\s*("me=e-1,he=e-1
"
"	Function list
"
syn keyword	virtualbasicTodo		contained TODO
"
"	Catch errors caused by wrong parenthesis
"
syn region	virtualbasicParen		transparent start='(' end=')' contains=ALLBUT,@virtualbasicParenGroup
syn match	virtualbasicParenError	")"
syn match	virtualbasicInParen	contained "[{}]"
syn cluster	virtualbasicParenGroup	contains=virtualbasicParenError,virtualbasicSpecial,virtualbasicTodo,virtualbasicUserCont,virtualbasicUserLabel,virtualbasicBitField
"
"	Integer number, or floating point number without a dot and with "f".
"
"syn region	virtualbasicHex		start="&h" end="\W"
"syn region	virtualbasicHexError	start="&h\x*[g-zG-Z]" end="\W"
"syn match	virtualbasicInteger	"\<\d\+\(u\=l\=\|lu\|f\)\>"
"
"	Floating point number, with dot, optional exponent
"
syn match	virtualbasicFloat		"\<\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\=\>"
"
"	Floating point number, starting with a dot, optional exponent
"
syn match	virtualbasicFloat		"\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
"
"	Floating point number, without dot, with exponent
"
syn match	virtualbasicFloat		"\<\d\+e[-+]\=\d\+[fl]\=\>"
"
"	Hex number
"
"syn case match
"syn match	virtualbasicOctal		"\<0\o*\>"
"syn match	virtualbasicOctalError	"\<0\o*[89]"
"
"	String and Character contstants
"
syn region	virtualbasicString		start='"' end='"' contains=virtualbasicSpecial,virtualbasicTodo
syn region	virtualbasicString		start="'" end="'" contains=virtualbasicSpecial,virtualbasicTodo
"
"	Comments
"
syn match	virtualbasicSpecial	contained "\\."
syn region	virtualbasicComment	start="^rem" end="$" contains=virtualbasicSpecial,virtualbasicTodo
syn region	virtualbasicComment	start=":\s*rem" end="$" contains=virtualbasicSpecial,virtualbasicTodo
syn region	virtualbasicComment	start="\s*#" end="$" contains=virtualbasicSpecial,virtualbasicTodo
syn region	virtualbasicComment	start="^#" end="$" contains=virtualbasicSpecial,virtualbasicTodo
syn region	virtualbasicComment	start="{" end="}" contains=virtualbasicSpecial,virtualbasicTodo
"
"	Now do the comments and labels
"
syn region	virtualbasicLabel  	start="£" end="\s"
syn region	virtualbasicLabel  	start="@" end="\s"
"
"	Create the clusters
"
"syn cluster	virtualbasicNumber		contains=virtualbasicHex,virtualbasicOctal,virtualbasicInteger,virtualbasicFloat
"syn cluster	virtualbasicError		contains=virtualbasicHexError,virtualbasicOctalError
"
"	Used with OPEN statement
"
"syn match	virtualbasicFilenumber	"#\d\+"
syn match	virtualbasicMathOperator	"[\+\-\=\|\*\/\>\<\%\()[\]]" contains=virtualbasicParen
"
"	The default methods for highlighting.  Can be overridden later
"
hi def link virtualbasicArrays		StorageClass
hi def link virtualbasicBitManipulation	Operator
hi def link virtualbasicCompilerSwitches	PreCondit
hi def link virtualbasicConsole		Special
hi def link virtualbasicDataTypes		Type
hi def link virtualbasicDateTime		Type
hi def link virtualbasicDebug		Special
hi def link virtualbasicErrorHandling	Special
hi def link virtualbasicFiles		Special
hi def link virtualbasicFunctions		Function
hi def link virtualbasicGraphics		Function
hi def link virtualbasicHardware		Special
hi def link virtualbasicLogical		Conditional
hi def link virtualbasicMath		Function
hi def link virtualbasicMemory		Function
hi def link virtualbasicMisc		Special
hi def link virtualbasicModularizing	Special
hi def link virtualbasicMultithreading	Special
hi def link virtualbasicShell		Special
hi def link virtualbasicEnviron		Special
hi def link virtualbasicPointer		Special
hi def link virtualbasicPredefined		PreProc
hi def link virtualbasicPreProcessor	PreProc
hi def link virtualbasicProgramFlow	Statement
hi def link virtualbasicString		String
hi def link virtualbasicTypeCasting	Type
hi def link virtualbasicUserInput		Statement
hi def link virtualbasicComment		Comment
hi def link virtualbasicConditional	Conditional
hi def link virtualbasicError		Error
hi def link virtualbasicIdentifier		Identifier
hi def link virtualbasicInclude		Include
hi def link virtualbasicGenericFunction	Function
hi def link virtualbasicLabel		Label
hi def link virtualbasicLineNumber		Label
hi def link virtualbasicMathOperator	Operator
hi def link virtualbasicNumber		Number
hi def link virtualbasicSpecial		Special
hi def link virtualbasicTodo		Todo

let b:current_syntax = "virtualbasic"

" vim: ts=8
