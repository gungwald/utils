/***************************************************************************
 *
 * du.c
 * Copyright (c) 2004 Bill Chatfield
 * All rights reserved
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <lmerr.h>

int displayRegularFilesAlso = 0;
int displayBytes = 0;
int summarize = 0;

/* This function was taken from Microsoft's Knowledge Base Article 149409
   and modified to fix the formatting. */
void DisplayErrorText(DWORD dwLastError)
{
    HMODULE hModule = NULL; /* default to system source */
    LPSTR MessageBuffer;
    DWORD dwBufferLength;
    DWORD dwBytesWritten;

    /* If dwLastError is in the network range, load the message source */
    if (dwLastError >= NERR_BASE && dwLastError <= MAX_NERR) {
        hModule = LoadLibraryEx(TEXT("netmsg.dll"), NULL, LOAD_LIBRARY_AS_DATAFILE);
    }

    /* Call FormatMessage() to allow for message text to be acquired
       from the system or the supplied module handle */
    dwBufferLength = FormatMessageA(
            FORMAT_MESSAGE_ALLOCATE_BUFFER |
            FORMAT_MESSAGE_IGNORE_INSERTS |
            FORMAT_MESSAGE_FROM_SYSTEM | /* always consider system table */
            ((hModule != NULL) ? FORMAT_MESSAGE_FROM_HMODULE : 0),
            hModule, /* Module to get message from (NULL == system) */
            dwLastError,
            MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), /* Default language */
            (LPSTR) &MessageBuffer,
            0,
            NULL);
        
    if (dwBufferLength) {
        /* Output message string on stderr */
        WriteFile(GetStdHandle(STD_ERROR_HANDLE), MessageBuffer, dwBufferLength, &dwBytesWritten, NULL);
        /* Free the buffer allocated by the system */
        LocalFree(MessageBuffer);
    }
    /* If you loaded a message source, unload it */
    if (hModule != NULL) {
        FreeLibrary(hModule);
    }
}

void usage()
{
    puts("Usage: du [OPTION]... [FILE]...");
    puts("Summarize disk usage of each FILE, recursively for directories.");
    puts("File and directory sizes are written in kilobytes.");
    puts("1 kilobyte = 1024 bytes");
    puts("");
    puts("-a          write counts for all files, not just directories");
    puts("-b          print size in bytes");
    puts("-s          display only a total for each argument");
    puts("-?, --help  display this help and exit");
    puts("--version   output version information and exit");
    puts("");
    puts("Example: du -s *");
    puts("");
    puts("Report bugs to <bill_chatfield@yahoo.com>");
}

void version()
{
    puts("du for Windows - Version 1.0");
    puts("Copyright(c) 2004 Bill Chatfield <bill_chatfield@yahoo.com>");
    puts("Distributed under the GNU General Public License.");
    puts("");
    puts("This du is written to the native WIN32 C API so that");
    puts("it will be as fast as possible.  It does not depend");
    puts("on any special UNIX emulation libraries.  It also");
    puts("displays correct values for file and directory sizes");
    puts("unlike some other versions of du ported from UNIX-like");
    puts("operating systems.");
}

int removeElement(int argc, char *argv[], int elementNumber)
{
    int i;
    for (i = elementNumber; i < argc - 1; i++) {
        argv[i] = argv[i + 1];
    }
    return i;
}

int setSwitches(int argc, char *argv[])
{
    int i = 0;
    int newArgumentCount = 0;
    newArgumentCount = argc;
    while (i < newArgumentCount) {
        if (strcmp(argv[i], "/?") == 0 || strcmp(argv[i], "-?") == 0 || strcmp(argv[i], "--help") == 0) {
            usage();
            exit(EXIT_SUCCESS);
        } else if (strcmp(argv[i], "--version") == 0) {
            version();
            exit(EXIT_SUCCESS);
        } else if (strcmp(argv[i], "/a") == 0 || strcmp(argv[i], "-a") == 0) {
            displayRegularFilesAlso = 1;
            newArgumentCount = removeElement(newArgumentCount, argv, i);
        } else if (strcmp(argv[i], "/b") == 0 || strcmp(argv[i], "-b") == 0) {
            displayBytes = 1;
            newArgumentCount = removeElement(newArgumentCount, argv, i);
        } else if (strcmp(argv[i], "/s") == 0 || strcmp(argv[i], "-s") == 0) {
            summarize = 1;
            newArgumentCount = removeElement(newArgumentCount, argv, i);
        } else {
            i++;
        }
    }
    if (displayRegularFilesAlso && summarize) {
        fprintf(stderr, "du: ERROR with arguments: cannot both summarize and show all entries\n");
        exit(EXIT_FAILURE);
    }
    return newArgumentCount;
}

void printFileSize(LPCTSTR fileName, unsigned long size)
{
    if (! displayBytes) {
        size = size / 1024.0 + 0.5;  /* Convert to KB and round */
    }
    printf("%-7lu %s\n", size, fileName);
}

unsigned long getSize(LPCTSTR fileName, int isTopLevel)
{
    unsigned long size = 0;
    DWORD fileAttr;
    HANDLE hFind;
    WIN32_FIND_DATA findFileData;
    int done = 0;
    DWORD lastError;
    char searchPattern[MAX_PATH + 1];
    LPCTSTR childFileName;
    char childPath[MAX_PATH + 1];

    fileAttr = GetFileAttributes(fileName);
    if (fileAttr == INVALID_FILE_ATTRIBUTES) {  /* An error occured */
        lastError = GetLastError();
        fprintf(stderr, "du: ERROR getting attributes for file ``%s'': ", fileName);
        DisplayErrorText(lastError);
        fputs("", stderr);  /* Write end of line */
    } else if (fileAttr & FILE_ATTRIBUTE_DIRECTORY) {  /* It is a directory */
        strncpy(searchPattern, fileName, MAX_PATH - 3);
        strncat(searchPattern, "\\*", 3);
        hFind = FindFirstFile(searchPattern, &findFileData);
        if (hFind == INVALID_HANDLE_VALUE) {
            lastError = GetLastError();
            done = 1;
            fprintf(stderr, "du: ERROR getting handle for file listing ``%s'': ", searchPattern);
            DisplayErrorText(lastError);
            fputs("", stderr);  /* Write end of line */
        } else {
            while (! done) {
                childFileName = findFileData.cFileName;
                if (strcmp(childFileName, ".") != 0 && strcmp(childFileName, "..") != 0) {
                    strncpy(childPath, fileName, MAX_PATH);
                    strncat(childPath, "\\", MAX_PATH - strlen(childPath));
                    strncat(childPath, childFileName, MAX_PATH - strlen(childPath));
                    size += getSize(childPath, 0);
                }
                if (! FindNextFile(hFind, &findFileData)) {
                    lastError = GetLastError();
                    if (lastError == ERROR_NO_MORE_FILES) {
                        done = 1;
                    } else {
                        fprintf(stderr, "du: ERROR getting next file in directory ``%s'': ", fileName);
                        DisplayErrorText(lastError);
                        fputs("", stderr);  /* Write end of line */
                    }
                }
            }
            FindClose(hFind);  /* Only close it if it got opened successfully */
            if (! summarize || isTopLevel) {
                printFileSize(fileName, size);
            }
        }
    } else {  /* It is a regular file */
        hFind = FindFirstFile(fileName, &findFileData);
        if (hFind == INVALID_HANDLE_VALUE) {
            lastError = GetLastError();
            fprintf(stderr, "du: ERROR getting handle for file ``%s'': ", fileName);
            DisplayErrorText(lastError);
            fputs("", stderr);  /* Write end of line */
        } else {
            size = (findFileData.nFileSizeHigh * (MAXDWORD+1)) + findFileData.nFileSizeLow;
            FindClose(hFind);
            if (displayRegularFilesAlso || isTopLevel) {
                printFileSize(fileName, size);
            }
        }
    }
    return size;
}

int main(int argc, char *argv[])
{
    int i;
    argc = setSwitches(argc, argv);
    if (argc > 1) {
        for (i = 1; i < argc; i++) {
            getSize(argv[i], 1);
        }
    } else {
        getSize(".", 1);
    }
    /* system("PAUSE"); */
    return 0;
}
