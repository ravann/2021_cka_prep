set -x 
sudo kubeadm init --config /tmp/kubeadm-config.yaml

sudo kubeadm token create --print-join-command > /tmp/setup_join.sh

### Setup network on the cluster
sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

### Copy config to root user
sudo mkdir -p /root/.kube
sudo cp -p /etc/kubernetes/admin.conf /root/.kube/config

### Setup config for non-root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown -R $(id -u):$(id -g) $HOME/.kube

cat /tmp/bashrc >> $HOME/.bashrc
