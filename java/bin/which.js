#!/usr/bin/env rhino

if (typeof WScript !== 'undefined' && typeof arguments === 'undefined') {
    WScript.Echo("This is a Rhino script. It won't work with Window Script Host.");
    WScript.Quit(0);
}

importClass(Packages.java.lang.System);
importClass(Packages.java.io.File);

var findAll = false;
var pathSep = environment["path.separator"];
var path    = System.getenv("PATH").split(pathSep);
var pathExtEnv = System.getenv("PATHEXT");
var pathExt = null;
if (pathExtEnv == null) {
	pathExt = null;
}
else {
	pathExt = pathExtEnv.split(pathSep);
}

for (var i = 0; i < arguments.length; i++) {
    var name = arguments[i];
    if (name == "-a") {
        findAll = true;
    }
    else {
        for (var j = 0; j < path.length; j++) {
            var dir = path[j];
            if ( pathExt == null ) {
                var file = new File( dir, name );
                if ( file.isFile()) {
                    print(file);
                    if ( !findAll ) {
                        System.exit(0);
                    }
                }
            }
            else {
                for (var k=0; k < pathExt.length; k++) {
                    var ext = pathExt[k];
                    var file = new File( dir, name + ext.toLowerCase() );
                    if ( file.isFile() ) {
                        print(file);
                        if ( !findAll ) {
                            System.exit(0);
                        }
                    }
                }
            }
        }
    }
}



