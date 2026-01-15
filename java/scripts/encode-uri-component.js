// Name: escape.js
// Should be run with: rhino escape.js [args ...]

// Desc:URI encodes all arguments or stdin (rhino impl)

if (arguments.length > 0) {
    // If there are arguments, decode them.
    for (var i = 0; i < arguments.length; i++) {
        print(encodeURIComponent(arguments[i]));
    }
}
else {
    // If there are no arguments, then read standard input.
    var stdin = new BufferedReader(new InputStreamReader(System["in"]));
    var line;
    while ((line = stdin.readLine()) != null) {
        print(encodeURIComponent(line));
    }
    stdin.close();
}
