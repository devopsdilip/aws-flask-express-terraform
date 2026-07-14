#!/bin/bash
set -e

apt-get update -y

apt-get install -y git curl

curl -fsSL https://deb.nodesource.com/setup_22.x | bash -

apt-get install -y nodejs

cd /home/ubuntu

git clone https://github.com/devopsdilip/aws-flask-express-terraform.git

chown -R ubuntu:ubuntu /home/ubuntu/aws-flask-express-terraform

cd /home/ubuntu/aws-flask-express-terraform/app/frontend

npm install

cat >/etc/systemd/system/express.service <<EOF
[Unit]
Description=Express Frontend
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/aws-flask-express-terraform/app/frontend
Environment=BACKEND_URL=http://${backend_ip}:5000
ExecStart=/usr/bin/npm start
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

systemctl enable express

systemctl restart express



