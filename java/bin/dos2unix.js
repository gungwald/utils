/*  dos2unix.js 

        - Desc:Windows Script Host implementation of dos2unix
        - Converts a text file from DOS to UNIX format
        - Implements in Windows the dos2unix command found on Linux & BSD UNIX
        - Will conform to behavior of UNIX command for operational efficiency
        - Runs "out of the box" on Windows, requiring no additional components
        - Usage: dos2unix <filenames>
  
    Copyright 2015 Bill Chatfield
  
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>. */

/*  Documentation for Windows Script Host features used herein:
 
    CreateTextFile   https://msdn.microsoft.com/en-us/library/5t9b5c0c%28v=vs.84%29.aspx
    FileSystemObject https://msdn.microsoft.com/en-us/library/2z9ffy99%28v=vs.84%29.aspx
    GetTempName      https://msdn.microsoft.com/en-us/library/w0azsy9b%28v=vs.84%29.aspx
    OpenTextFile     https://msdn.microsoft.com/en-us/library/314cz14s%28v=vs.84%29.aspx */

// This is like an import or include statement.
var fs = new ActiveXObject("Scripting.FileSystemObject");

// Constants
var IOMODE_READ = 1;
var IOMODE_WRITE = 2;
var IOMODE_APPEND = 8;
var CHARSET_DEFAULT = -2;
var CHARSET_UNICODE = -1;
var CHARSET_ASCII = 0;
var DOS_LINE_TERMINATOR = "\r\n";
var UNIX_LINE_TERMINATOR = "\n";
var SPECIAL_FOLDER_TEMP = 2;

/**
 * Provides a temporary file name in the system temporary folder.
 * Does not create the file.
 *
 * @return {String} Absolute file name of a temp file that does not
 *                  yet exist.
 */
function getTempName() {
    var tempDir = fs.GetSpecialFolder(SPECIAL_FOLDER_TEMP);
    var tempFile = fs.GetTempName();
    return fs.BuildPath(tempDir, tempFile);
}

/**
 * Replaces the line terminator for every line in a text file with the given
 * lineTerminator string.
 *
 * @param {String} inputFileName    The name of the file to process
 * @param {String} lineTerminator   The character sequence to put at the
 *                                  end of each line, replacing any
 *                                  line terminator characters that were
 *                                  there previously
 */
function replaceLineTerminators(inputFileName, lineTerminator) {
    // File is the type returned by GetFile, which will be assigned to 
    // inputFile.
    var inputFile = fs.GetFile(inputFileName);

    // Folder is the type of the File.ParentFolder property, which will be 
    // assigned to the folder var.
    var folder = inputFile.ParentFolder;

    // TextStream is the type returned by OpenTextFile, which will be 
    // assigned to inputStream.
    var inputStream = fs.OpenTextFile(inputFileName, IOMODE_READ, false, CHARSET_DEFAULT);

    // String is the type returned by getTempName, which will be assigned to 
    // outputFileName.
    var outputFileName = getTempName();

    // TextStream is the type returned by CreateTextFile, which will be 
    // assigned to outputStream.
    var outputStream = fs.CreateTextFile(outputFileName);

    while (! inputStream.AtEndOfStream) {
        var line = inputStream.ReadLine();
        // Write just the line with no line terminator characters.
        outputStream.Write(line);

        // *******************************************************************
        // 
        // This is the line where the goal is accomplished. Everything else is
        // just setup work.
        //
        // *******************************************************************
        outputStream.Write(lineTerminator);
    }
    outputStream.Close();
    inputStream.Close();

    // Overwrite the original file with the modified file. This method
    // avoids a partially converted file if the event of a failure.
    inputFile.Delete(true);
    fs.MoveFile(outputFileName, inputFileName);
}

/**
 * Converts the contents of a text from DOS/Windows format to UNIX format.
 * The contents of the original file are overwritten with the same data
 * in UNIX text format.
 * <p>
 * A file that is already in UNIX text format will be processed but the
 * resulting file will be identical to the original. In other words, if
 * the input is not in the expected DOS/Windows text format, trying to
 * convert it to the format it is already in does not result in a 
 * corrupted file. In other words, a bad input file does not cause a
 * failure.
 * <p>
 * The DOS/Windows text file format has a carriage return character
 * (ASCII code 13) and a line feed character (ASCII code 10) at the end
 * of each line. This is sometimes abbreviated as CRLF.
 * <p>
 * The UNIX text file format has only a line feed (a.k.a. new line 
 * character) at the end of each line.
 *
 * @param {String} fileName The name of the file to be converted from 
 *                          DOS to UNIX format
 */
function dos2unix(fileName) {
    replaceLineTerminators(fileName, UNIX_LINE_TERMINATOR);
}

// Convert all files given on the command line.
for (var i = 0; i < WScript.Arguments.length; i++) {
    dos2unix(WScript.Arguments(i));
}


