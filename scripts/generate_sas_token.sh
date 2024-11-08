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

#durée de validité du SAS TOKEN=> a revoir(expiry)
DURATION_IN_HOURS=24

#Generation du SAS Token pour le conteneur de Blob Storage
echo "Generating SAS Token for Azure Blob Storage container"
SAS_TOKEN=$(az storage container generate-sas \
    --account-name $STORAGE_ACCOUNT_NAME \
    --name $BLOB_STORAGE_NAME \
    --permissions racwdl \
    --expiry $(date -u -d "24  hour" '+%Y-%m-%dT%H:%MZ') \
    --output tsv)

# SAS Token generation success control
if [ -z "$SAS_TOKEN" ]; then
    echo "SAS_TOKEN generation failed."
    exit 1
fi

# Update or add SAS Token generated in .env
echo "Updating SAS Token in .env..."
sed -i '/^SAS_TOKEN=/d' .env

echo "SAS_TOKEN='$SAS_TOKEN'" >> .env

echo "SAS Token generated and updated in .env file"