. 00_env.sh
. 00_env_gen.sh

ids=$(az vm list \
    --subscription $az_subscription \
    --resource-group $azure_resource_group \
    --query "[].id" -o tsv)

for id in $ids
do
    echo starting $id
    az vm start --ids $id
done
