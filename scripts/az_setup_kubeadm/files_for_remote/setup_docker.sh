set -x 

### Letting iptables see bridged traffic 
sudo echo br_netfilter > /etc/modules-load.d/k8s.conf

sudo echo net.bridge.bridge-nf-call-ip6tables = 1 > /etc/sysctl.d/k8s.conf
sudo echo net.bridge.bridge-nf-call-iptables = 1 >> /etc/sysctl.d/k8s.conf

sudo sysctl --system

### Setup Docker
sudo apt-get update

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" > /tmp/docker.list
sudo cp /tmp/docker.list /etc/apt/sources.list.d/

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

### Configure the Docker daemon, in particular to use systemd for the management of the container’s cgroups.

cat <<EOF > /tmp/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sudo mkdir -p /etc/docker
sudo cp /tmp/daemon.json /etc/docker/daemon.json

sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
