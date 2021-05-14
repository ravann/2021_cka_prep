set -x 
. 00_env.sh

uid=`uuidgen`

#  az account list-locations --output table | grep -i asia
export azure_resource_group=$uid
echo "Creating resource group"
az group create --name $azure_resource_group --location southeastasia --subscription $az_subscription

if [ -e files_for_remote/id_rsa ]
then
    echo "RSA file exists using it ... "
else
    ssh-keygen -f files_for_remote/id_rsa -N ''
fi

### Create ssh key 
echo Creating sshkey
az sshkey create --location southeastasia \
    --resource-group $azure_resource_group \
    --name $az_ssh_key \
    --public-key "@files_for_remote/id_rsa.pub"

### Create VNET
az network vnet create \
    -g $azure_resource_group \
    -n $az_vnet_name \
    --address-prefix 196.0.0.0/16 \
    --subnet-name $az_subnet_name \
    --subnet-prefix 196.0.0.0/24

### Create Master Node

# az vm image list --output table
# az vm list-sizes -l southeastasia --output table

echo Creating master node
az vm create \
    --subscription $az_subscription \
    --resource-group $azure_resource_group \
    --name $az_vm_name_master \
    --image $az_vm_image \
    --admin-username $az_linux_admin_user \
    --ssh-key-name $az_ssh_key \
    --priority $az_vm_priority \
    --max-price $az_vm_max_price \
    --size $az_vm_size \
    --vnet-name $az_vnet_name \
    --subnet $az_subnet_name \
    --nsg-rule SSH \
    --eviction-policy $az_vm_eviction_policy

# Get the public IP of master
export azure_master_ip=`az vm show -d -g $azure_resource_group -n $az_vm_name_master --query publicIps -o tsv`

# Save the environment variables
rm -f 00_env_gen.sh
for i in `env | grep -i azure `
do
    echo $i >> 00_env_gen.sh
done

echo ssh -i files_for_remote/id_rsa $az_linux_admin_user@$azure_master_ip >> 101_ssh.sh

rm -f $worker_ips_file
# Exit if we dont want worker nodes
if [ $WORKER_NODES -eq 0 ]
then
    exit 0
fi
for i in `seq $WORKER_NODES`
do
worker_name=${az_vm_name_worker_prefix}${i}
az vm create \
    --subscription $az_subscription \
    --resource-group $azure_resource_group \
    --name $worker_name \
    --image $az_vm_image \
    --admin-username $az_linux_admin_user \
    --ssh-key-name $az_ssh_key \
    --size $az_vm_size \
    --priority $az_vm_priority \
    --max-price $az_vm_max_price \
    --eviction-policy $az_vm_eviction_policy \
    --vnet-name $az_vnet_name \
    --subnet $az_subnet_name \
    --nsg-rule SSH \
    --public-ip-address ""

export worker_ip=`az vm show -d -g $azure_resource_group -n $worker_name --query privateIps -o tsv`
echo $worker_ip >> $worker_ips_file

done
