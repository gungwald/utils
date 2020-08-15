import java.util.jar.JarEntry
import java.util.jar.JarFile
import java.util.regex.Pattern
import java.nio.file.Path
import java.nio.file.Paths

Path getRelativePath(File f) {
    return new File(System.getProperty("user.dir")).toPath().relativize(f.toPath())
}

void findFileInJar(File jar, Pattern whatToFind) {
    JarFile jarFile = new JarFile(jar)
    for (JarEntry entry : jarFile.entries()) {
        def name = entry.getName()
        if (whatToFind.matcher(name).find()) {
            printf("%s: %s%n", getRelativePath(jar).toString(), name)
        }
    }
}

void findFile(File nameToBeSearched, Pattern whatToFind) {
    if (nameToBeSearched.isDirectory()) {
        for (File entry : nameToBeSearched.listFiles()) {
            findFile(entry, whatToFind)
        }
    }
    else if (nameToBeSearched.getName().endsWith(".jar")) {
        findFileInJar(nameToBeSearched, whatToFind)
    }
    else if (whatToFind.matcher(nameToBeSearched.getName()).find()) {
        println(getRelativePath(nameToBeSearched))
    }
}

//////////////////////
//   Main Program 
//////////////////////

File startDirectory = new File(System.getProperty("user.dir"));
String[] searchPatterns = this.args

if (this.args.length > 1) {
    // There are at least 2 arguments, enough for both a directory and
    // a search pattern, because both are necessary.
    File firstArg = new File(this.args[0])
    if (firstArg.isDirectory()) {
        // If the first argument is a directory then it will be the start
        // directory. The rest of the arguments will be search patterns.
        startDirectory = firstArg;
        searchPatterns = this.args[1..this.args.length-1]
    }
}

if (searchPatterns.length > 0) {
    for (String searchPattern : searchPatterns) {
        String classSearchPattern = searchPattern + ".class"
        findFile(startDirectory, Pattern.compile(classSearchPattern, Pattern.CASE_INSENSITIVE))
    }
}
else {
    // If there are no arguments, as for a search pattern and start from
    // the current directory. Oh, and tell the user he's a dumb-ass. :-)
    print("Find what, dumb-ass? ")
    BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in))
    searchPattern = stdin.readLine()
    String classSearchPattern = searchPattern + ".class"
    findFile(startDirectory, Pattern.compile(classSearchPattern, Pattern.CASE_INSENSITIVE))
}

