#!/bin/sh

curl -o certdata.txt 'https://mxr.mozilla.org/mozilla/source/security/nss/lib/ckfw/builtins/certdata.txt?raw=1'

curl -o mk-ca-bundle.pl 'https://raw.githubusercontent.com/bagder/curl/master/lib/mk-ca-bundle.pl'
perl mk-ca-bundle.pl -n > ca-bundle.crt

curl -o keyutil-0.4.0.jar 'https://github.com/use-sparingly/keyutil/releases/download/0.4.0/keyutil-0.4.0.jar'
# https://github.com/alastairmccormack/keyutil.git
java -jar keyutil-0.4.0.jar --import --new-keystore trustStore.jks --password changeit --import-pem-file ca-bundle.crt


# Now you can specify the JVM arguments to have it use the new SSL certificate authority file:
# -Djavax.net.ssl.trustStore=/path/to/trustStore.jks
# If you specified a password other than changeit you will also need to pass the password into the JVM arguments:
# -Djavax.net.ssl.trustStorePassword=yourPassword
