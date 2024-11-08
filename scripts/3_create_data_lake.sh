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
