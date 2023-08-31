#!/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $BASEDIR/inc.sh

cd $BASEDIR/../ansible
ansible-galaxy collection install kubernetes.core:==${ANSIBLE_GALAXY_COLLECTION_K8S_VERSION} -p .