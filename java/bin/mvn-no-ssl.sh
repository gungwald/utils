#!/bin/sh

mvn -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true -Dmaven.wagon.http.ssl.ignore.validity.dates=true "$@"

# These might also work in ~/.mavenrc (on one line) or ~/.mvn/maven.config (on separate lines)
