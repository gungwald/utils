if (arguments.length > 0) {
    // If there are arguments, decode them.
    for (var i = 0; i < arguments.length; i++) {
        print(decodeURIComponent(arguments[i]));
    }
}
else {
    // If there are no arguments, then read standard input.
    var stdin = new BufferedReader(new InputStreamReader(System.in));
    var line;
    while ((line = stdin.readLine()) != null) {
        print(decodeURIComponent(line));
    }
    stdin.close();
}
