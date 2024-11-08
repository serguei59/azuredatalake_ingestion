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

# blob storage to adls2 container pipeline creation
echo "Creating blob storage to data lake container pipeline..."
az datafactory pipeline create \
    --factory-name $DATA_FACTORY_NAME \
    --name "BlobstorageToDataLakePipeline" \
    --pipeline "$(cat pipeline_config/data_ingestion_pipeline.json)"
