# include .env file and export
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

VAGRANT_CONFIG ?= ../config.rb


# .PHONEY
.PHONEY: up halt destroy trybuild rebuild status ssh vmlist vmdestroy logcleanup


# Vagrant jobs
init:
	@if [ ! -d "kubespray" ]; then \
		git clone https://github.com/kubernetes-sigs/kubespray.git ; \
		python3 -m pip install netaddr jmespath
		ansible-galaxy collection install ansible.posix community.general kubernetes.core ansible.netcommon
	fi

kubeconfig:
	cd kubespray && vagrant ssh-config k8s-1 > /tmp/ssh-config && \
		ssh -F /tmp/ssh-config k8s-1 'sudo cp /etc/kubernetes/admin.conf /home/vagrant && sudo chmod 0644 /home/vagrant/admin.conf'
		scp -F /tmp/ssh-config k8s-1:/home/vagrant/admin.conf ~/.kube/config


# VBox jobs
vmlist:
	VBoxManage list vms
vmdestroy:
	VBoxManage list vms | cut -d ' ' -f 1 | sed -e "s/\"//g" | xargs -I {} VBoxManage unregistervm {} --delete
