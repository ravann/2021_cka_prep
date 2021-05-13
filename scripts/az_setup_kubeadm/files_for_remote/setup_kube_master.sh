sudo kubeadm init --config /tmp/kubeadm-config.yaml

sudo kubeadm token create --print-join-command > /tmp/setup_join.sh
