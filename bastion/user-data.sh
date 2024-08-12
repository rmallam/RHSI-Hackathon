#!/bin/bash

# Set the desired state for PasswordAuthentication (yes/no)
STATE="yes"

# Backup the original sshd_config file
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Update or add the PasswordAuthentication setting
if grep -q "^#PasswordAuthentication" /etc/ssh/sshd_config; then
    # Uncomment the line and set the desired state
    sed -i "s/^#PasswordAuthentication.*/PasswordAuthentication $STATE/" /etc/ssh/sshd_config
elif grep -q "^PasswordAuthentication" /etc/ssh/sshd_config; then
    # Update the existing line with the desired state
    sed -i "s/^PasswordAuthentication.*/PasswordAuthentication $STATE/" /etc/ssh/sshd_config
else
    # Add the line if it doesn't exist
    echo "PasswordAuthentication $STATE" >> /etc/ssh/sshd_config
fi

# Restart the SSH service to apply changes
systemctl restart sshd

echo "PasswordAuthentication has been set to $STATE and the SSH service has been restarted."

curl -L https://github.com/skupperproject/skupper/releases/download/1.7.3/skupper-cli-1.7.3-linux-amd64.tgz | tar -xzv
mv skupper /usr/local/bin
curl -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.14.4/openshift-client-linux-4.14.4.tar.gz | tar -xzv
mv oc /usr/local/bin
mv kubectl /usr/local/bin
for i in red blue green yellow purple orange olive brown black grey 
do
  adduser $i
  echo RedHat1! | passwd --stdin $i
done
