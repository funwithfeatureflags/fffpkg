[Unit]
Description=flagd
After=network.target
Wants=network.service

[Service]
EnvironmentFile=/etc/default/flagd
Type=forking
PIDFile=/var/run/flagd/flagd.pid
#User=flagd
#Group=flagd
ExecStart=/usr/bin/flagd $OPTIONS -p /var/run/flagd/flagd.pid
KillMode=process
Restart=no

[Install]
WantedBy=multi-user.target
