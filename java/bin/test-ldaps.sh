#!/bin/sh

LDAPS_HOST=ldap-ec500.cardinalhealth.net
LDAPS_PORT=636

BIN_DIR=$(dirname "$0") && [ "$BIN_DIR" = "." ] && BIN_DIR=$(pwd)
CLASSES_DIR=$(dirname "$BIN_DIR")/classes
JAVA=java

if [ -n "$JAVA_HOME" ]
then
	printf "Use JAVA_HOME %s? (y/n) " "$JAVA_HOME"
	read ANSWER
	if [ "$ANSWER" = "y" ]
	then
		JAVA="$JAVA_HOME"/bin/java
	else
        	echo Will use java.home property instead.
	fi
fi

"$JAVA" -XshowSettings:properties -version 2>&1 | grep "    java.home"

OPTS="-Djavax.net.debug=ssl"
#OPTS+=" -Djavax.net.ssl.trustStore=$HOME/.keystore"

echo $OPTS

exec "$JAVA" $OPTS -cp "$CLASSES_DIR" SSLPoke $LDAPS_HOST $LDAPS_PORT

# Values for javax.net.debug:
#
# all            turn on all debugging
# ssl            turn on ssl debugging
#
# The following can be used with ssl:
#
#    record       enable per-record tracing
#    handshake    print each handshake message
#    keygen       print key generation data
#    session      print session activity
#    defaultctx   print default SSL initialization
#    sslctx       print SSLContext tracing
#    sessioncache print session cache tracing
#    keymanager   print key manager tracing
#    trustmanager print trust manager tracing
#    pluggability print pluggability tracing
#
#    handshake debugging can be widened with:
#    data         hex dump of each handshake message
#    verbose      verbose handshake message printing
#
#    record debugging can be widened with:
#    plaintext    hex dump of record plaintext
#    packet       print raw SSL/TLS packets
#
# The format for using the additional ssl flags is ssl:[flag] for example:
#
# -Djavax.net.debug=ssl:record or -Djavax.net.debug=ssl:handshake.

