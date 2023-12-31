# How to Initialize the Project

## Run Time Environment

The project was tested under the following environment. Make sure you meet the environment dependencies or similar so that it can be run successfully.

- Host OS: Ubuntu 22.04
- Python 3.10.6
- Ansible 2.15.2 (2.14 - 2.16 should all be compatible)
- Use [Kubespray](https://github.com/kubernetes-sigs/kubespray/tree/master), with HEAD on Commit ID [d2383d27a9f60b9dee6e5ffc762480d1e8f011af](https://github.com/kubernetes-sigs/kubespray/tree/d2383d27a9f60b9dee6e5ffc762480d1e8f011af), the Commit ID can be changed in `.env` file via `KUBESPRAY_CHECKPOINT_COMMIT_ID` var.
- VirtualBox 6.1.38_Ubuntur153438
- Vagrant 2.3.7

## Project Initialization

1. Clone the repo:

```
git clone git@github.com:jeffreycai/sandbox-k8s-kubespray.git
```

2. Initialize

```
make init
```

This will checkout [Kubespray](https://github.com/kubernetes-sigs/kubespray/tree/master), with HEAD on Commit ID [d2383d27a9f60b9dee6e5ffc762480d1e8f011af](https://github.com/kubernetes-sigs/kubespray/tree/d2383d27a9f60b9dee6e5ffc762480d1e8f011af) and apply the diff file `vagrant/Vagrantfile.diff`. also install some dependencies.

