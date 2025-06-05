#!/bin/bash

# initializa instances
export DEBIAN_FRONTEND=noninteractive
# Start time
echo "Start time: $(date "+%H:%M:%S")" > ~/start_time.txt
# Maximum number of attempts
max_attempts=10

# Timeout in seconds between each attempt
timeout=1

# Command to execute
command="sudo apt-get -y update"

# Attempt counter
attempt=0

# Loop until the command is successful or the maximum number of attempts is reached
until $command
do
  exit_status=$?
  attempt=$((attempt+1))

  if [ $attempt -eq $max_attempts ]
  then
    echo "Attempt $attempt failed and there are no more attempts left!"
    return $exit_status
  fi

  echo "Attempt $attempt failed! Trying again in $timeout seconds..."
  sleep $timeout
done

sudo apt-get -y upgrade
sleep $timeout

# from https://docs.aws.amazon.com/es_es/systems-manager/latest/userguide/agent-install-ubuntu-64-snap.html
sudo snap install amazon-ssm-agent --classic
sudo snap list amazon-ssm-agent
sudo snap start amazon-ssm-agent
sudo snap services amazon-ssm-agent
sleep $timeout

sudo apt  install -y docker.io 
sleep $timeout
sudo usermod -aG docker ubuntu
newgrp docker
# docker run hello-world
sleep $timeout
sudo su
su ubuntu
# docker network
cd ~
git clone https://github.com/crmobeto97/Image-AI-Backend.git
cd Image-AI-Backend/network/
echo "Running Docker network creation..."
bash create_docker_network.sh
echo "Done!"

# Backend
cd ~/Image-AI-Backend/src/
docker build . -t python-1
### Run model in local volume/host ###
cd ia_model/
git clone https://github.com/pjreddie/darknet
cd darknet
#### make dependencies ####
apt install -y make build-essential
#### finish make dependencies ####
make
wget https://data.pjreddie.com/files/yolov3.weights
# Run container
# docker run --rm -d --name=backend -p 8000:8000 python-1
docker run --rm -d --name=backend -p 8000:8000 -v $(pwd):"/home/ia_model/darknet" python-1

# Front-End
cd ~
git clone https://github.com/crmobeto97/Image-IA-UI
cd Image-IA-UI/

## set .env for front-end ##
# Get the public IP from EC2 instance metadata
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Check if we got a valid IP
if [ -z "$PUBLIC_IP" ]; then
  echo "Error: Failed to retrieve public IP."
  exit 1
fi

# Create the .env file with the required variables
cat <<EOF > .env
NEXT_PUBLIC_ENVIRONMENT="prod"
NEXT_PUBLIC_API_URL="http://$PUBLIC_IP:8000/"
EOF

echo ".env file created successfully with public IP: $PUBLIC_IP"

## end set .env ##

docker build . -t node-1
docker run --rm -d --name="front-end" -p 3000:3000 node-1

# End time
echo "End time: $(date "+%H:%M:%S")" > ~/end_time.txt