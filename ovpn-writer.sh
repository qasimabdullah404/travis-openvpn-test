#!/bin/sh

##
## Usage: ./ovpn-writer.sh SERVER CA_CERT CLIENT_CERT CLIENT_KEY SHARED_SECRET > client.ovpn
##
## Thanks to https://gist.github.com/renatolfc/18e428b5a758df24455b

server=${1?"The server address is required"}
cacert=${2?"The path to the ca certificate file is required"}
client_cert=${3?"The path to the client certificate file is required"}
client_key=${4?"The path to the client private key file is required"}
tls_key=${5?"The path to the TLS shared secret file is required"}

cat << EOF
client
dev tun
remote ${server}
resolv-retry infinite
nobind
persist-key
persist-tun
ca [inline]
cert [inline]
key [inline]
tls-auth [inline] 1
verb 1
keepalive 10 120
port 1194
proto udp
cipher BF-CBC
comp-lzo
remote-cert-tls server
<ca>
EOF
cat ${cacert}
cat << EOF
</ca>
<cert>
EOF
cat ${client_cert}
cat << EOF
</cert>
<key>
EOF
cat ${client_key}
cat << EOF
</key>
<tls-auth>
EOF
cat ${tls_key}
cat << EOF
</tls-auth>
EOF