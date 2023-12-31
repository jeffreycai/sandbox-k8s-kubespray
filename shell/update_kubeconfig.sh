#!/bin/bash

set -e

# Update local ~/.kube/config with a copy from Master node config file

MASTER_NODE_HOST_ID=${CLUSTER_INSTANCE_PREFIX}-1
CONF_FILE=${CLUSTER_INSTANCE_PREFIX}.admin.conf

# copy the file locally
cd kubespray
vagrant ssh-config $MASTER_NODE_HOST_ID > /tmp/ssh-config
ssh -F /tmp/ssh-config $MASTER_NODE_HOST_ID 'sudo cp /etc/kubernetes/admin.conf /home/vagrant && sudo chmod 0644 /home/vagrant/admin.conf'
scp -F /tmp/ssh-config $MASTER_NODE_HOST_ID:/home/vagrant/admin.conf ../$CONF_FILE

# update the file so that it uses the node's private ip instead of 127.0.0.1
PRIVATE_IP=$(vagrant ssh -c "ip addr show eth1 | grep 'inet ' | awk '{ print $2}'" ${MASTER_NODE_HOST_ID} | cut -d'/' -f1 | sed 's/[^0-9\.]//g')
sed -i "s/127.0.0.1/${PRIVATE_IP}/g" ../$CONF_FILE

echo "* DONE: Cluster kubeconfig file copied as 'admin.conf'. You can copy over to your local kubeconfig"