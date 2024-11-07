#!/bin/bash

#load existing environnment variables
if [ -f .env ]; then
    source .env
else
    echo ".env not found, please create one filled with required variables"
fi

# data lake account and container creation
echo "Creating datalake gen2 storage account..."
az storage account create \
    --name $DATA_LAKE_NAME \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --sku Standard_LRS \
    --hns true
echo "data lake $DATA_LAKE_NAME created."

echo "Creating  data lake's container..." 
az storage container create \
    --account-name $DATA_LAKE_NAME \
    --name $DATA_LAKE_CONTAINER_NAME \
    --public-access off
echo "data lake's container $DATA_LAKE_CONTAINER_NAME created.."
