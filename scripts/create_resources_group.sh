#!/bin/bash

#load existing environnment variables
if [ -f .env ]; then
    source .env
else
    echo ".env not found, please create one filled with required variables"
fi

#resource group creation
echo "Creating Resource Group..."
az group create \
    --name $RESOURCE_GROUP \
    --location $LOCATION
echo "Resource group $RESOURCE_GROUP created."
