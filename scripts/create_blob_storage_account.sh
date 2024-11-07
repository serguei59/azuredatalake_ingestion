#!/bin/bash

#load existing environnment variables
if [ -f .env ]; then
    source .env
else
    echo ".env not found, please create one filled with required variables"
fi

# storage account and blob storage creation
az storage account create \
    --name $STORAGE_ACCOUNT_NAME \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --sku Standard_LRS


az storage container create \
    --account-name $STORAGE_ACCOUNT_NAME \
    --name $BLOB_STORAGE_NAME \
    --public-access off