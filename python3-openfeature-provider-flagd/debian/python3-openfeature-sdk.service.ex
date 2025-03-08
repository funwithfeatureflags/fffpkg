[Unit]
Description=python3-openfeature-sdk
After=network.target
Wants=network.service

[Service]
EnvironmentFile=/etc/default/python3-openfeature-sdk
Type=forking
PIDFile=/var/run/python3-openfeature-sdk/python3-openfeature-sdk.pid
#User=python3-openfeature-sdk
#Group=python3-openfeature-sdk
ExecStart=/usr/bin/python3-openfeature-sdk $OPTIONS -p /var/run/python3-openfeature-sdk/python3-openfeature-sdk.pid
KillMode=process
Restart=no

[Install]
WantedBy=multi-user.target
