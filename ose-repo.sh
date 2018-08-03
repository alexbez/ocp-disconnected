#!/bin/sh

REPO_PATH="./ocp-3.9.33-repo/"

subscription-manager register --auto-attach
echo "System registered and attached"

subscription-manager attach --pool="8a85f98a61e216760162006a90841c60" # OpenShift pool ID
echo "OpenShift subscription registered"

subscription-manager repos --disable="*"
echo "All repos disabled"

subscription-manager repos \
--enable="rhel-7-server-rpms" \
--enable="rhel-7-server-extras-rpms" \
--enable="rhel-7-fast-datapath-rpms" \
--enable="rhel-7-server-ansible-2.4-rpms" \
--enable="rhel-7-server-ose-3.9-rpms"
echo "Required repos enabled"

yum -y install yum-utils createrepo docker git
echo "Necessary packages installed"

for repo in rhel-7-server-rpms rhel-7-server-extras-rpms rhel-7-fast-datapath-rpms rhel-7-server-ansible-2.4-rpms rhel-7-server-ose-3.9-rpms
do
  echo "-----------------------------------------------------------------------------------------------"
  echo "Syncing repo: $repo"
  echo "-----------------------------------------------------------------------------------------------"
  reposync --gpgcheck -lm --repoid=${repo} --download_path=$REPO_PATH -n
  createrepo -v $REPO_PATH${repo} -o $REPO_PATH${repo}
done

echo "Unregistering from OpenShift subscription"
subscription-manager remove --pool="8a85f98a61e216760162006a90841c60"

echo "Done"
