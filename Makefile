# include .env file and export
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

VAGRANT_CONFIG ?= ../vagrant/config.rb


# .PHONEY
.PHONEY: up halt destroy trybuild rebuild status ssh vmlist vmdestroy logcleanup


# Vagrant jobs
init:
	@if [ ! -d "kubespray" ]; then \
		git clone https://github.com/kubernetes-sigs/kubespray.git ; \
		cd kubespray ; \
		git checkout $(KUBESPRAY_CHECKPOINT_COMMIT_ID) ; \
		git apply ../vagrant/Vagrantfile.diff ; \
		mkdir vagrant ; \
		ln -s $(CURDIR)/vagrant/config.rb $(CURDIR)/kubespray/vagrant/config.rb ; \
		python3 -m pip install netaddr jmespath ; \
		ansible-galaxy collection install ansible.posix community.general kubernetes.core ansible.netcommon ; \
	fi

kubeconfig:
	@bash shell/update_kubeconfig.sh

up:
	cd kubespray && vagrant up

provision_shell:
	cd kubespray && vagrant provsion --provision-with shell

# VBox jobs
vmlist:
	VBoxManage list vms
vmdestroy:
	VBoxManage list vms | cut -d ' ' -f 1 | sed -e "s/\"//g" | xargs -I {} VBoxManage unregistervm {} --delete
