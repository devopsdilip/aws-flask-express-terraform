#!/bin/bash

# Update packages
apt-get update -y

# Install required software
apt-get install -y \
python3 \
python3-pip \
python3-venv \
git \
curl

# Install Node.js 22
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt-get install -y nodejs

# Clone project
cd /home/ubuntu

git clone https://github.com/devopsdilip/aws-flask-express-terraform.git

chown -R ubuntu:ubuntu aws-flask-express-terraform

#############################
# Backend
#############################

cd /home/ubuntu/aws-flask-express-terraform/app/backend

python3 -m venv venv

source venv/bin/activate

pip install --upgrade pip

pip install -r requirements.txt

nohup python3 app.py > backend.log 2>&1 &

#############################
# Frontend
#############################

cd /home/ubuntu/aws-flask-express-terraform/app/frontend

npm install

export BACKEND_URL=http://localhost:5000

nohup npm start > frontend.log 2>&1 &
