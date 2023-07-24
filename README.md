# Provision Kubernetes Clusters with Kuberspray / Vagrant

## Initiatives

While [minikube](https://github.com/kubernetes/minikube) is good to get started with Kuberenetes, it comes short in the following aspects:

**Single Node**: Minikube only allows you to run a single-node Kubernetes cluster, which means it doesn't simulate the behavior of a multi-node cluster. This limits its ability to test multi-node behaviors such as inter-node networking, load balancing, and cluster scaling.

**Limited Resources**: Minikube's resources are constrained by the local machine's hardware. Therefore, it might not handle large, resource-intensive applications as effectively as a full Kubernetes setup would.

**Lack of High Availability**: Since Minikube runs on a single node, it cannot provide high availability or simulate failure scenarios across multiple nodes.

**Performance**: Running Minikube on a local machine can lead to performance issues. Depending on your local machine's capabilities, running a large number of pods or services could slow down the system significantly.

Comparatively, [Kubespray](https://github.com/kubernetes-sigs/kubespray) is designed to bootstrap production-grade Kubernetes clusters on a larger scale. It allows for multiple nodes and provides high availability, making it better suited for more extensive and complex systems. Here are a few aspects where Kubespray stands out compared to Minikube:

**Multi-node Cluster**: Kubespray supports deploying multi-node Kubernetes clusters, giving a more realistic production-like environment.

**High Availability**: Kubespray provides high availability configurations, enabling the cluster to withstand node failures without affecting the services running on it.

**Broad Infrastructure Support**: Kubespray can be used to deploy a Kubernetes cluster on various platforms including AWS, GCE, Azure, OpenStack, vSphere, Packet, and bare metal.

**Flexibility**: Kubespray provides greater flexibility and configurability, allowing you to tailor the cluster to suit your needs.

Therefore, I constructed this project to be one that you can learn Kubernetes in a full scale with Kuberspray, while still be able to deploy on a local machine (though you might probably need a good machine with memory and cpu resources.)

## How to Use

Follow the below steps to provision your local kubernetes cluster:

1. Update `.env` file with:

  - `KUBESPRAY_CHECKPOINT_COMMIT_ID`, this will be the git commit id for [Kubespray](https://github.com/kubernetes-sigs/kubespray) master branch. We use a specific commit id instead of `main` branch to avoid any unpredictable impacts that might be brought by the changes for the project in `main` branch in the future.

  - `CLUSTER_INSTANCE_PREFIX`, this is the instance prefix. e.g. if you put `k8s` here, the node created will be named as `k8s-1`, `k8s-2` ...

2. Follow [INSTALL.md](INSTALL.md) for initialization.

3. Customize Cluster Settings

You can check the default cluster config in [kubespray/Vagrantfile](kubespray/Vagrantfile) (You'll need to check in the kubespray repo first). An overriden config file can be found at [vagrant/config.rb](vagrant/config.rb). Add your overriden values in the file will override default config.

To change the bootstrap script that runs during provision the nodes (e.g. install software on nodes or change node configurations), you can update file [vagrant/common.sh](vagrant/common.sh)

4. Create the cluster by running:

```
make up
```

5. Generate `kubeconfig` file to access the cluster

Run `make kubeconfig` to generate the kubeconfig file. The file will be named as `${CLUSTER_INSTANCE_PREFIX}.admin.conf`.
Update your local kubeconfig file on your host machine, i.e. `~/.kube/config`, with the content of the file. or, update `KUBECONFIG` env var to point to the kubeconfig file.

```
export KUBECONFIG=$(pwd)/${CLUSTER_INSTANCE_PREFIX}.admin.conf
```

6. Enjoy Kubernetes!

```
kubectl get nodes
```

## Managing the Cluster

```
# shutdown all nodes
make halt

# destroy all nodes
make destroy

# list all vms
make vmlist

# force delete all vms
make vmdestroy

# show vagrant vms status
make status

# rerun shell provisioner on nodes
make provision_shell
```