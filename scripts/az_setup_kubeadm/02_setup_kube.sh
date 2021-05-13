. 00_env.sh
. 00_env_gen.sh

# Copy the files to remote
scp -o StrictHostKeyChecking=no -i files_for_remote/id_rsa files_for_remote/* -p $az_linux_admin_user@$azure_master_ip:/tmp/

ssh -o StrictHostKeyChecking=no -i files_for_remote/id_rsa $az_linux_admin_user@$azure_master_ip <<EOF
cp -p /tmp/id_rsa /home/k8user/.ssh/
sudo mkdir -p /root/.ssh
sudo cp -p /tmp/id_rsa /root/.ssh

chmod 755 /tmp/setup_*

/tmp/setup_docker.sh | tee /tmp/setup_docker.log
/tmp/setup_kube.sh | tee /tmp/setup_kube.log
/tmp/setup_kube_master.sh | tee /tmp/setup_kube_master.log
/tmp/setup_workers.sh | tee /tmp/setup_workers.log

EOF

