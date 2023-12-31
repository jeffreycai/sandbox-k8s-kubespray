# packages install
sudo apt-get update 
sudo apt-get install -y containerd net-tools
wget https://github.com/containerd/nerdctl/releases/download/v1.4.0/nerdctl-1.4.0-linux-amd64.tar.gz
tar zxvf nerdctl-1.4.0-linux-amd64.tar.gz
sudo mv nerdctl /usr/local/bin/

VERSION="v1.27.1"
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
sudo tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
rm -f crictl-$VERSION-linux-amd64.tar.gz
