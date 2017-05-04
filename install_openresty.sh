cat <<'EOF' > /etc/yum.repos.d/OpenResty.repo
[openresty]
name=Official OpenResty Repository
baseurl=https://copr-be.cloud.fedoraproject.org/results/openresty/openresty/epel-$releasever-$basearch/
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/openresty/openresty/pubkey.gpg
enabled=1
enabled_metadata=1
EOF
git submodule update --init
yum install -y openresty readline-devel autoconf wget curl

chmod +x shadowsocks_install/shadowsocks-libev.sh
./shadowsocks_install/shadowsocks-libev.sh 2>&1 | tee shadowsocks-libev.log

chmod 500 ./kcp-server/install-kcp-server.sh
./kcp-server/install-kcp-server.sh install
