. ./00_env_sensitive.sh

# VNET details
export az_vnet_name=k8_vnet
export az_subnet_name=k8_subnet

# SSH KEY details
export az_ssh_key=k8_ssh_key

# VM Details
export az_vm_image=UbuntuLTS
export az_vm_name_master=k8master
export az_linux_admin_user=k8user
export az_vm_size=Standard_D2as_v4
export az_vm_max_price=0.02
export az_vm_priority=Spot
export az_vm_eviction_policy=Delete

export WORKER_NODES=2

export az_vm_name_worker_prefix="worker"

export worker_ips_file=files_for_remote/worker_ips.txt
