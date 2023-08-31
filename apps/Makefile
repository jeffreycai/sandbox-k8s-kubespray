## load and export .env
ifneq (,$(wildcard ./.env))
	include .env
	export
endif

pip_install:
	pip3 install -r requirements.txt
.PHONY: pip_install

ansible_galaxy:
	@bash bash/ansible_galaxy.sh
.PHONY: ansible_galaxy

bootstrap: ansible_galaxy
	@ansible-playbook ansible/bootstrap.yaml \
	    -i ansible/hosts \
		-e "release_name=$(RELEASE_NAME)" \
		-e "python_path=$(PYTHON_PATH)"
.PHONY: start

#sample_app:
#	@ansible-playbook ansible/sample_app.yaml \
#	    -i ansible/hosts \
#		-e "release_name=$(RELEASE_NAME)" \
#		-e "python_path=$(PYTHON_PATH)"
#.phony: start

cleanup: ansible_galaxy
	@ansible-playbook ansible/cleanup.yaml \
	    -i ansible/hosts \
		-e "release_name=$(RELEASE_NAME)" \
		-e "python_path=$(PYTHON_PATH)"
.phony: cleanup
