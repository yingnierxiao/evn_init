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
sudo yum --disablerepo="*" --enablerepo="openresty" list available
git submodule update --init
yum install -y readline-devel autoconf wget curl lrzsz openresty

chmod +x shadowsocks_install/shadowsocks-libev.sh
./shadowsocks_install/shadowsocks-libev.sh 2>&1 | tee shadowsocks-libev.log

chmod 500 ./kcp-server/install-kcp-server.sh
./kcp-server/install-kcp-server.sh install


netstat -nutlp

# tcp        0      0 127.0.0.1:12948         0.0.0.0:*               LISTEN      1118/socks5         
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      5041/sshd           
# tcp        0      0 0.0.0.0:8388            0.0.0.0:*               LISTEN      873/ss-server       
# tcp6       0      0 :::22                   :::*                    LISTEN      5041/sshd           
# tcp6       0      0 :::8388                 :::*                    LISTEN      873/ss-server       
# udp        0      0 0.0.0.0:8388            0.0.0.0:*                           873/ss-server       
# udp        0      0 127.0.0.1:323           0.0.0.0:*                           5306/chronyd        
# udp6       0      0 :::45678                :::*                                1126/kcp-server     
# udp6       0      0 :::8388                 :::*                                873/ss-server       
# udp6       0      0 ::1:323                 :::*                                5306/chronyd  
