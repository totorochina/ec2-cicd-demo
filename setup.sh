################################################
# This is for bootstrap of EC2 user_data
# Prequisites:
# IAM role for
#	fetching s3 files
# or equivalent aws credentials
# 
################################################
#!/bin/bash

# install CodeDeploy agent
yum update -y
yum install -y ruby wget
cd /home/ec2-user/
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
chmod +x ./install
./install auto
chkconfig codedeploy-agent on
service codedeploy-agent start

# install CloudWatch agent
yum install -y awslogs
chkconfig awslogs on
service awslogs start

# setup demo web app
pip install tornado
mkdir -p /data
chmod 1777 /data
cd /data
aws s3 cp s3://totorochina-private/apidemo.zip .
unzip apidemo.zip
bash start.sh
