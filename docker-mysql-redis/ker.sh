echo "* soft nofile 1024000" >> /etc/security/limits.conf
echo "* hard nofile 1024000" >> /etc/security/limits.conf
echo "* soft nproc 65535" >> /etc/security/limits.conf
echo "* hard nproc 65535" >> /etc/security/limits.conf
echo "DefaultLimitNOFILE=1024000" >> /etc/systemd/system.conf
echo "DefaultLimitNPROC=65535" >> /etc/systemd/system.conf
echo "DefaultLimitNOFILE=1024000" >> /etc/systemd/user.conf
echo "DefaultLimitNPROC=65535" >> /etc/systemd/user.conf
echo "systemctl daemon-reexec" >> /etc/systemd/user.conf


cat > /etc/sysctl.d/99-custom.conf << EOF
fs.file-max = 1048576
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_fin_timeout = 10
net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_keepalive_probes = 5
net.ipv4.tcp_max_syn_backlog = 8192
net.core.somaxconn = 65535
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.core.netdev_max_backlog = 65536
net.ipv4.tcp_fastopen = 3
vm.swappiness = 10
vm.dirty_ratio = 20
vm.dirty_background_ratio = 5
vm.oom_kill_allocating_task = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.conf.all.rp_filter = 1
# net.ipv6.conf.all.disable_ipv6 = 1
EOF
sysctl --system


cat > /etc/sysctl.d/99-docker-pid.conf << EOF
kernel.pid_max = 4194304
kernel.threads-max = 4194304
EOF
sysctl --system

