@echo off

goto BEGIN

rem **************************************************************************
rem 
rem 
rem PURPOSE:
rem 
rem     The purpose of this batch file is to start scripts written in
rem     various scripting languages in a consistent manner with a
rem     well-defined and orgainzed mechanism. It should allow you to
rem     concentrate on your script without spending time working on
rem     how your end-user will invoke the script. It should make it 
rem     easy for your end-user to invoke your script.
rem 
rem     The simplest way to start a script, such as a JavaScript
rem     (Mozilla Rhino) script is to use a single line batch file,
rem     such as:
rem
rem         @java -jar rhino.jar myscript.js
rem
rem     Limiting the platform-specific batch file to a single line is
rem     a good way to make sure it contains no application logic. But
rem     it is also desirable to be able to find the script if it
rem     happens to reside in one of several directories based on
rem     different deployment patterns. Additionally it is desirable
rem     to be able to start multiple types of scripts with the same
rem     code.
rem
rem
rem **************************************************************************
rem
rem
rem REQUIREMENTS:
rem 
rem     (1) To start scripts using a well-defined set of rules.
rem     (2) To start scripts of different languages using a common set
rem         of rules for consistency.
rem     (3) To start scripts of different languages using a common set
rem         of code, a single batch file, (this batch file) so that the
rem         code only has to be written once and the same code can be
rem         used in all cases. 
rem     (3) To be flexible enough to find the scripts when they are
rem         located in multiple possible locations based on different
rem         deployment patterns: all files in one directory, each type
rem         of file in a different directory (bin, lib, scripts), etc.
rem     (4) To automatically find the target script by using the name
rem         of this batch file and the list of known extensions to
rem         determine the name of the script.
rem     (5) To pass all command line parameters on to the target 
rem         script.
rem     (6) To be easy to read, understand, and extend with more script
rem         types. It is not necessary for this batch file to run as
rem         fast as possible or to be as small as possible, or to use
rem         the coolest most complicated features possible. What is
rem         important is that it is organized and presented in such a
rem         ways that other people can understand how it works.
rem
rem
rem **************************************************************************
rem
rem
rem CONSTRAINTS:
rem
rem     (1) This batch file should contain no application logic. The
rem         application logic is wholely the responsibility of the 
rem         target script or jar. It does not belong in this platform-
rem         specific batch file.
rem     (2) This batch file should not do any processing of incoming
rem         command line parameters. That is wholely the responsibility
rem         of the target script or jar.
rem
rem
rem **************************************************************************
rem
rem 
rem AUTHOR:
rem 
rem     Bill Chatfield
rem 
rem         Corporate e-mail:   bill.chatfield@cardinalhealth.com
rem 
rem         Personal  e-mail:   bill_chatfield@yahoo.com
rem 
rem
rem **************************************************************************
rem 
rem 
rem LICENSE:
rem 
rem     GPL
rem 
rem
rem **************************************************************************
rem 
rem 
rem SUPPORTED SCRIPT LANGUAGES:
rem 
rem     Name        Ext   Jar            Web Site
rem     ----        ---   ---            --------
rem     BeanShell   .bsh  bsh-2.0b4.jar  http://www.beanshell.org/
rem     JavaScript  .js   rhino.jar         http://www.mozilla.org/rhino/
rem     Sleep       .sl   sleep.jar      http://sleep.dashnine.org/
rem     Perl        .pl   N/A            http://www.perl.org/
rem 
rem 
rem **************************************************************************
rem 
rem 
rem NAME SYNCHRONIZATION:
rem 
rem     This batch file should be named the same as your script.
rem     For example, if your script is named scanlogs.js then this batch
rem     file should be copied to scanlogs.bat. This batch file uses its
rem     name at runtime to determine which script it is going to invoke.
rem     It looks for scripts that are named identical to itself, except
rem     that they have script extensions instead of the .bat extension,
rem     in this order:
rem  
rem         .bsh    for BeanShell
rem         .js     for JavaScript
rem         .sl     for Sleep
rem         .pl     for Perl
rem 
rem
rem **************************************************************************
rem 
rem 
rem DIRECTORY STRUCTURE:
rem 
rem     This batch file requires the following directory structure
rem     to invoke a script named scanlogs.js:
rem  
rem         Top folder              (Any name - convention is C:\opt)
rem         |
rem         +---bin                 (Contains copies of this batch file)
rem         |       scanlogs.bat    (A copy of this batch file)
rem         |
rem         +---lib                 (Contains interpreter jar files)
rem         |       rhino.jar          (Required for JavaScript scripts)
rem         |
rem         \---scripts             (Contains your scripts)
rem                 scanlogs.js     (Your JavaScript script)
rem 
rem     The general case, with all possible target types is as
rem     follows:
rem 
rem         Top folder              (Any name - convention is C:\opt)
rem         |
rem         +---bin                 (Contains copies of this batch file)
rem         |       scriptA.bat     (A copy of this batch file)
rem         |       scriptB.bat	    (A copy of this batch file)
rem         |       scriptC.bat	    (A copy of this batch file)
rem         |       scriptD.bat	    (A copy of this batch file)
rem         |       programE.bat    (A copy of this batch file)
rem         |
rem         +---lib                 (Contains interpreter jar files)
rem         |       bsh-2.0b4.jar   (Required for BeahShell scripts)
rem         |       rhino.jar          (Required for JavaScript scripts)
rem         |       sleep.jar       (Required for Sleep scripts)
rem         |       programE.jar    (Your java program)
rem         |
rem         \---scripts             (Contains your scripts)
rem                 scriptA.bsh     (Your BeanShell script)
rem                 scriptB.js      (Your JavaScript script)
rem                 scriptC.sl      (Your Sleep script)
rem                 scriptD.pl      (Your Perl script)
rem 
rem
rem **************************************************************************

:BEGIN

setlocal ENABLEDELAYEDEXPANSION

rem ****************************************************************
rem
rem Define the executable commands that run the interpreted scripts.
rem For a particular script, PERL might be set to 'cqperl' to run
rem The ClearQuest Perl interpreter, for example.
rem
rem Some options for JAVA would be:
rem     (1) java                    - Sun java from PATH
rem     (2) %JAVA_HOME%\bin\java    - A specific java version
rem     (3) %IBM_JAVA_HOME%\java    - IBM's java
rem
rem Some options for PERL would be:
rem     (1) perl                    - Standard perl from PATH
rem     (2) cqperl                  - ClearQuest perl
rem     (3) ratlperl                - Rational perl
rem
rem ****************************************************************
set JAVA=java
set PERL=cqperl

rem *********************************************************************
rem 
rem Define variables for the name of this batch file and the directory it
rem resides in.
rem
rem Enter "call /?" at the Command Prompt to get documentation on these
rem bizarre but necessary % expressions.
rem 
rem *********************************************************************
set THIS_FILE=%~n0
set THIS_FILE_WITH_EXT=%~nx0
set THIS_DIR=%~dp0

rem **********************************************
rem
rem Remove trailing backslash from directory name.
rem
rem **********************************************
set THIS_DIR=%THIS_DIR:~0,-1%

rem *************************
rem
rem Define search directories
rem
rem *************************
set THIS_DIR_PARENT=%THIS_DIR%\..
set SCRIPTS=%THIS_DIR_PARENT%\scripts
set LIB=%THIS_DIR_PARENT%\lib

rem ************************************************
rem
rem Define search paths, based on search directories
rem
rem ************************************************
set SCRIPT_SEARCH_PATH="%THIS_DIR%" "%THIS_DIR_PARENT%" "%SCRIPTS%"
set JAR_SEARCH_PATH="%THIS_DIR%" "%THIS_DIR_PARENT%" "%LIB%"

rem *********************************************************
rem
rem Search for a script with the same name as this batch file
rem
rem *********************************************************

for %%s in (%SCRIPT_SEARCH_PATH%) do (

    rem ***************************
    rem 
    rem Look for a BeanShell script
    rem 
    rem ***************************

    set TARGET=%%~s\%THIS_FILE%.bsh
    if exist "!TARGET!" (
        set JAR_HAS_BEEN_FOUND=false
        for %%j in (%JAR_SEARCH_PATH%) do (
            set JAR=%%~j\bsh-2.0b4.jar
            if exist "!JAR!" (
                set JAR_HAS_BEEN_FOUND=true
                %JAVA% -cp "!JAR!" bsh.Interpreter "!TARGET!" %*
                goto END_OF_SEARCH
            )
        )
        if !JAR_HAS_BEEN_FOUND!==false (
            echo Found BeanShell script "!TARGET!" but not its interpreter: bsh-2.0b4.jar
        )
    )

    rem ********************************************
    rem 
    rem Look for a JavaScript (Mozilla Rhino) script
    rem 
    rem ********************************************
    
    set TARGET=%%~s\%THIS_FILE%.js
    if exist "!TARGET!" (
        set JAR_HAS_BEEN_FOUND=false
        for %%j in (%JAR_SEARCH_PATH%) do (
            set JAR=%%~j\rhino.jar
            if exist "!JAR!" (
                set JAR_HAS_BEEN_FOUND=true
                %JAVA% -jar "!JAR!" "!TARGET!" %*
                goto END_OF_SEARCH
            )
        )
        if !JAR_HAS_BEEN_FOUND!==false (
            echo Found JavaScript script "!TARGET!" but not its interpreter: rhino.jar
        )
    )

    rem ***********************
    rem 
    rem Look for a Sleep script
    rem 
    rem ***********************

    set TARGET=%%~s\%THIS_FILE%.sl
    if exist "!TARGET!" (
        set JAR_HAS_BEEN_FOUND=false
        for %%j in (%JAR_SEARCH_PATH%) do (
            set JAR=%%~j\sleep.jar
            if exist "!JAR!" (
                set JAR_HAS_BEEN_FOUND=true
                %JAVA% -jar "!JAR!" "!TARGET!" %*
                goto END_OF_SEARCH
            )
        )
        if !JAR_HAS_BEEN_FOUND!==false (
            echo Found Sleep script "!TARGET!" but not its interpreter: sleep.jar
        )
    )

    rem **********************
    rem 
    rem Look for a Perl script
    rem 
    rem **********************

    set TARGET=%%~s\%THIS_FILE%.pl
    if exist "!TARGET!" (
        %PERL% "!TARGET!" %*
        goto END_OF_SEARCH
    )
)
    
rem *******************************
rem 
rem Look for an executable jar file
rem 
rem *******************************

for %%j in (%JAR_SEARCH_PATH%) do (
    for %%x in (exe.jar jar) do (
        set TARGET=%%~j\%THIS_FILE%.%%x
        if exist "!TARGET!" (
            %JAVA% -jar "!TARGET!" %*
            goto END_OF_SEARCH
        )
    )
)

:END_OF_SEARCH

endlocal

