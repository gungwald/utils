#!/usr/bin/env org-dashnine-sleep

## Please see file perltidy.ERR
$findAll = 0;
$pathSep = systemProperties()['path.separator'];
@path    = split( $pathSep, [ System getenv : "PATH" ] );
@pathExt = split( $pathSep, [ System getenv : "PATHEXT" ] );

foreach $name (@ARGV) {
    if ( $name eq "-a" ) {
        $findAll = 1;
    }
    else {
        foreach $dir (@path) {
            if ( size(@pathExt) == 0 ) {
                $file = getFileProper( $dir, $name );
                if ( -isFile $file) {
                    println($file);
                    if ( !$findAll ) {
                        exit();
                    }
                }
            }
            else {
                foreach $ext (@pathExt) {
                    $file = getFileProper( $dir, $name . lc($ext) );
                    if ( -isFile $file) {
                        println($file);
                        if ( !$findAll ) {
                            exit();
                        }
                    }
                }
            }
        }
    }
}
