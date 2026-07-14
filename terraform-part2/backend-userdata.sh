#!/bin/bash
set -e

apt-get update -y

apt-get install -y \
python3 \
python3-pip \
python3-venv \
git

cd /home/ubuntu

git clone https://github.com/devopsdilip/aws-flask-express-terraform.git

chown -R ubuntu:ubuntu /home/ubuntu/aws-flask-express-terraform

cd /home/ubuntu/aws-flask-express-terraform/app/backend

python3 -m venv venv

source venv/bin/activate

pip install --upgrade pip

pip install -r requirements.txt

cat >/etc/systemd/system/flask.service <<EOF
[Unit]
Description=Flask Backend
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/aws-flask-express-terraform/app/backend
Environment=PATH=/home/ubuntu/aws-flask-express-terraform/app/backend/venv/bin
ExecStart=/home/ubuntu/aws-flask-express-terraform/app/backend/venv/bin/python app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

systemctl enable flask

systemctl restart flask
