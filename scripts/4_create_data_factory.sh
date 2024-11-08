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

#data factory creation avec identité managée activée
echo "Creating Data Factory..."
az datafactory create \
    --resource-group $RESOURCE_GROUP \
    --name $DATA_FACTORY_NAME \
    --location $LOCATION 

if [ $? -eq 0 ]; then
    echo "Data factory $DATA_FACTORY_NAME created.."
else
    echo "Failed to create Data Factory"
    exit 1
fi

# Recuperer l identite managée eventuelle du Data factory


