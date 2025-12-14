#!/bin/sh

# Desc:Creates new Java JKS cacerts from latest Mozilla certificates database

# TODO - Automatically backup the old cacerts and install the new one
# TODO - Don't run the Perl script. Download ca-bundle.crt from somewhere,
#        preferably from a plain http address, avoiding a catch-22.
#        Or rewrite mk-ca-bundle.pl in Java.
# TODO - Rewrite in Java so you don't need Bash. Depends on the above
#        because Java 1.4 may not have the latest certs installed to make
#        an https connection. Or a working curl would be required. 
#        Another option would be to distribute the Java program with the
#        latest cacerts file and specify that as the system keystore in
#        the startup sh/bat file.

MOZ_CERTS_URL='https://mxr.mozilla.org/mozilla/source/security/nss/lib/ckfw/builtins/certdata.txt?raw=1'
MK_CA_BUNDLE_URL='https://raw.githubusercontent.com/bagder/curl/master/lib/mk-ca-bundle.pl'
KEYUTIL_URL='https://github.com/use-sparingly/keyutil/releases/download/0.4.0/keyutil-0.4.0.jar'
MOZ_CERTS=certdata.txt
MK_CA_BUNDLE=$HOME/bin/mk-ca-bundle.pl
KEYUTIL=$HOME/lib/keyutil-0.4.0.jar
CA_BUNDLE=ca-bundle.crt

# Perl script does this automatically
#curl -o "$MOZ_CERTS" "$MOZ_CERTS_URL" || exit

if [ ! -f "$MK_CA_BUNDLE" ]
then
  mkdir -p $(dirname "$MK_CA_BUNDLE") || exit
  curl -o "$MK_CA_BUNDLE" "$MK_CA_BUNDLE_URL" || exit
fi

if [ ! -f "$KEYUTIL" ]
then
  mkdir -p $(dirname "$KEYUTIL") || exit
  curl -L -o "$KEYUTIL" "$KEYUTIL_URL" || exit
fi

#perl "$MK_CA_BUNDLE" -n > "$CA_BUNDLE" || exit
perl "$MK_CA_BUNDLE" || exit

# https://github.com/alastairmccormack/keyutil.git
java -jar "$KEYUTIL" \
  --import \
  --new-keystore trustStore.jks \
  --password changeit \
  --import-pem-file "$CA_BUNDLE" || exit

# Now you can specify the JVM arguments to have it use the new SSL certificate authority file:
# -Djavax.net.ssl.trustStore=/path/to/trustStore.jks
# If you specified a password other than changeit you will also need to pass the password into the JVM arguments:
# -Djavax.net.ssl.trustStorePassword=yourPassword
