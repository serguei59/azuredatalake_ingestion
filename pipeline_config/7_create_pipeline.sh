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

# Linked Services creation
echo "Creation des Linked Services vers Blob Storage et Data Lake"
az datafactory linked-service create --factory-name $DATA_FACTORY_NAME --resource-group $RESOURCE_GROUP --name BlobLinkedService --properties @pipeline_config/linked_service_blob.json
if [ $? -eq 0 ]; then
    echo "Blob storage linked-service created"
else
    echo "Failed to create Blob storage linked-service"
    exit 1
fi

az datafactory linked-service create --factory-name $DATA_FACTORY_NAME --resource-group $RESOURCE_GROUP --name DataLakeLinkedService --properties @pipeline_config/linked_service_datalake.json
if [ $? -eq 0 ]; then
    echo "Datalake linked-service created"
else
    echo "Failed to create Datalake linked-service"
    exit 1
fi

# Datasets creation
echo "Creation des Datasets des Blob Storage et Data Lake"
az datafactory dataset create --factory-name $DATA_FACTORY_NAME --resource-group $RESOURCE_GROUP --name BlobDataset --properties @pipeline_config/dataset_blob.json
if [ $? -eq 0 ]; then
    echo "Blob storage dataset created"
else
    echo "Failed to create Blob storage dataset"
    exit 1
fi

az datafactory dataset create --factory-name $DATA_FACTORY_NAME --resource-group $RESOURCE_GROUP --name DataLakeParquetDataset --properties @pipeline_config/dataset_datalake_parquet.json
if [ $? -eq 0 ]; then
    echo "Datalake parquet dataset created"
else
    echo "Failed to create Datalake parquet dataset"
    exit 1
fi

# Blob storage to adls2 container adf's pipeline creation
echo "Creating blob storage to data lake container pipeline..."
az datafactory pipeline create \
    --factory-name $DATA_FACTORY_NAME \
    --name "BlobstorageToDataLakePipeline" \
    --properties @pipeline_config/data_ingestion_pipeline.json \
    --resource_group $RESOURCE_GROUP

if [ $? -eq 0 ]; then
    echo "Data Factory Pipeline created"
else
    echo "Failed to create Data factory Pipeline"
    exit 1
fi

