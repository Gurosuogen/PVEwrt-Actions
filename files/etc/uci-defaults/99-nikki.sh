#!/bin/sh

. /etc/openwrt_release
arch="$DISTRIB_ARCH"
branch="openwrt-25.12"
repository_url="https://nikkinikki.pages.dev"
feed_url="$repository_url/$branch/$arch/nikki"

# 1. 直接明文写入 apk 密钥
echo "writing public key..."
mkdir -p /etc/apk/keys
cat << 'EOF' > /etc/apk/keys/nikki.pem
-----BEGIN PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAETOwt83tzTFqyvjwimjuuvslR40t6
XnROMwxZsC0iQAr2hHjuXX8qyhf5WaD2Hd897+Gc1/+4W4DMqroNp5w2Dg==
-----END PUBLIC KEY-----
EOF

# 2. 写入 apk 软件源 (feeds)
echo "add feed"
if [ -f /etc/apk/repositories.d/customfeeds.list ]; then
	sed -i '/nikki/d' /etc/apk/repositories.d/customfeeds.list
else
	mkdir -p /etc/apk/repositories.d
fi
echo "$feed_url/packages.adb" >> /etc/apk/repositories.d/customfeeds.list

exit 0
