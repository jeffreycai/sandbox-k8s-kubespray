#/bin/env bash

cd ../../kubespray

for ((i=1; i<=$V_NUM_INSTANCE; i++)); do
    IP=$(vagrant ssh ${CLUSTER_INSTANCE_PREFIX}-$i -c "ip addr" | grep $V_SUBNET_PREFIX | awk '{print $2}' | cut -d'/' -f1)
    echo "$CLUSTER_INSTANCE_PREFIX-$i    ..   $IP"
done