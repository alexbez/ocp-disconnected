#!/bin/sh
REPO_PATH="/media/sf_shared-folder/ose-3.9.33-repos/"
for repo in rhel-7-server-rpms rhel-7-server-extras-rpms rhel-7-fast-datapath-rpms rhel-7-server-ansible-2.4-rpms rhel-7-server-ose-3.9-rpms
do
  echo "-----------------------------------------------------------------------------------------------"
  echo "Syncing repo: $repo"
  echo "-----------------------------------------------------------------------------------------------"
  reposync --gpgcheck -lm --repoid=${repo} --download_path=$REPO_PATH -n
  createrepo -v $REPO_PATH${repo} -o $REPO_PATH${repo}
done
