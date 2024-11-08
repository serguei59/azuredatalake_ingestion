#!/bin/bash

#chemin vers .env retouvé quelque soit l endroit d ou le fichier est éxécuté
#$0 : représente le chemin du script actuellement exécuté
#dirname "$0" : permet d'obtenir le répertoire où se trouve le script.
ENV_FILE="$(dirname "$0")/../.env"
#load existing environnment variables
if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
else
    echo ".env not found, please create one filled with required variables"
fi

# Construct destination URL with SAS Token for Blob Storage
DEST_URL="https://${STORAGE_ACCOUNT_NAME}.blob.core.windows.net/${BLOB_STORAGE_NAME}?${SAS_TOKEN_blobstorage}"


#upload the file or repertory here using AzCopy
echo "Uploading $LOCAL_FILE_PATH to blob Storage"
azcopy copy "$LOCAL_FILE_PATH" "$DEST_URL" --from-to=LocalBlob --recursive=true

#sucess control of azcopy transfer
if [ $? -eq 0 ]; then
    echo "repertory & files uploaded successfully!"
else
    echo "repertory & files upload failed."
fi