##### Prevent laptop from going to sleep
```bash
sudoedit /etc/systemd/logind.conf
```
Update next configuration:
```
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
```

##### On login script
Create on-login script:
```bash
sudo touch ~/on-login.sh
cat << 'EOF' | sudo tee ~/on-login.sh
#!/bin/bash

sudo tlp start
EOF

sudo chmod +x ~/on-login.sh
```

Create on-login service:
```bash
sudo touch /etc/systemd/system/on-login.service
sudo nvim /etc/systemd/system/on-login.service
```
Add content to the `on-login.service`
```bash
cat << 'EOF' | sudo tee /etc/systemd/system/on-login.service
[Unit]
Description=On Login Script
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/home/ihor/on-login.sh
User=root
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable on-login.service
sudo systemctl start on-login.service
sudo systemctl status on-login.service
```