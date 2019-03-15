set -o errexit
set -o nounset
set -o pipefail

echo 'generating Root CA'
openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem -subj "/CN=quaylocalRootCA"
cp rootCA.pem stack/extra_ca_certs/rootCA.crt
cp rootCA.pem clairconfig/certs/rootCA.crt

echo 'generating clair ssl key pair using root CA'
openssl genrsa -out clairconfig/ssl.key 2048
openssl req -new -key clairconfig/ssl.key -out clairconfig/ssl.csr -subj "/CN=clair" -config clairconfig/openssl.cnf
openssl x509 -req -in clairconfig/ssl.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out clairconfig/ssl.crt -days 356 -extensions v3_req -extfile clairconfig/openssl.cnf
rm -f clairconfig/ssl.csr

echo 'generating quay ssl key pair using root CA'
openssl genrsa -out stack/ssl.key 2048
openssl req -new -key stack/ssl.key -out ssl.csr -subj "/CN=quay" -config stack/openssl.cnf
openssl x509 -req -in ssl.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out stack/ssl.cert -days 356 -extensions v3_req -extfile stack/openssl.cnf
rm -f ssl.csr
