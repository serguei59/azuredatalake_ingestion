#!/bin/bash

#chemin vers .env
#$0 : représente le chemin du script actuellement exécuté
#dirname "$0" : permet d'obtenir le répertoire où se trouve le script.
ENV_FILE="$(dirname "$0")/../.env"
#load existing environnment variables
if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
else
    echo ".env not found, please create one filled with required variables"
fi

# storage account and blob storage creation
echo "Creating storage account..."
az storage account create \
    --name $STORAGE_ACCOUNT_NAME \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --sku Standard_LRS
echo "Storage account $STORAGE_ACCOUNT_NAME created."



echo "Creating azure blob storage..."
az storage container create \
    --account-name $STORAGE_ACCOUNT_NAME \
    --name $BLOB_STORAGE_NAME \
    --public-access off
echo "Azure blob storage  $BLOB_STORAGE_NAME created."
